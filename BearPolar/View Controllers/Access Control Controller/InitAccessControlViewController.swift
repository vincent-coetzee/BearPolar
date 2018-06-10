//
//  DataProtectionViewController.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/02.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit
import LocalAuthentication

class InitAccessControlViewController: UIViewController 
    {
    private var pinCount = 0
    private var pin1 = PIN()
    private var pin2 = PIN()
    
    override func viewDidLoad() 
        {
        super.viewDidLoad()
        installCancelButton()
        actionTouchOrPIN()
        }
        
    private func installCancelButton()
        {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.onCancelTapped(_:)))
        }
        
    @IBAction func onCancelTapped(_ sender:Any?)
        {
        actionTouchOrPIN()
        }
        
    private func actionTouchOrPIN()
        {
        var touchIdAvailable = false
        if #available(iOS 8.0, *) 
            {
            var error: NSError?
            let hasTouchID = LAContext().canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
            if hasTouchID || (Int(error!.code) != kLAErrorBiometryNotAvailable) 
                {
                touchIdAvailable = true
                }
            }
        if touchIdAvailable
            {
            let alertController = UIAlertController(title: "Use Touch Id ?", message: "Biometric protection for your BearPolar data is available, would you like to use a PIN or biometrics ?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Biometrics", style: .default) 
                { 
                (action:UIAlertAction!) in
                DispatchQueue.main.async 
                    {
                    self.protectAccessWithTouchId()
                    }
                }
            let noAction = UIAlertAction(title: "PIN", style: .cancel) 
                { 
                (action:UIAlertAction!) in
                DispatchQueue.main.async 
                    {
                    self.protectAccessWithPIN()
                    }
                }
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            self.present(alertController, animated: true, completion:nil)
            }
        else
            {
            protectAccessWithPIN()
            }
        }

    private func protectAccessWithTouchId()
        {
        let authenticationContext = LAContext()
        var error: NSError?
        let reasonString = "Please confirm your fingerprint access to this device"
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else 
            {
            return
            }
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,localizedReason: reasonString,reply: 
                { 
                [unowned self] (success, error) -> Void in
                if( success ) 
                    {
                    self.moveToInformationIdentity()
                    }
                else 
                    {
                    if let error = error 
                        {
            
//            let message = self.errorMessageForLAErrorCode(error.code)
//            self.showAlertViewAfterEvaluatingPolicyWithMessage(message)
            
                        }
                    }
                })
        }
        
    private func protectAccessWithPIN()
        {
        let controller = PINViewController(nibName: "DigitPadView", bundle: nil)
        controller.PINEntryCompletion =
            {
            padView,pin in
            if self.pinCount == 0
                {
                self.pin1 = pin
                self.pinCount = 1
                padView.reset()
                controller.message = "Please confirm your 6 digit PIN."
                }
            else
                {
                self.pin2 = pin
                self.pinCount = 2
                }
            if self.pinCount == 2
                {
                if self.pin1 == self.pin2
                    {
                    self.moveToInformationIdentity()
                    }
                else 
                    {
                    controller.errorMessage = "The PINs do not match, please reenter"
                    controller.message = "Please enter a 6 digit PIN"
                    padView.reset()
                    self.pinCount = 0
                    }
                }
            }
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(controller.view)
        controller.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        controller.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        controller.view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        controller.view.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        }
        
    private func moveToInformationIdentity()
        {
        DispatchQueue.main.async
            {
            [unowned self] in
            self.performSegue(withIdentifier: "MoveToInitInformation", sender: self)
            }
        }
        
    override func didReceiveMemoryWarning() 
        {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    }
