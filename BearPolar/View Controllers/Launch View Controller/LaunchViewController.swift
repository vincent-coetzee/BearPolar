//
//  ViewController.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController 
    {
    @IBOutlet var actionButton:UIButton!
    @IBOutlet var topLabel:UILabel!
    @IBOutlet var bottomLabel:UILabel!
    
    override func viewDidLoad() 
        {
        super.viewDidLoad()
        var title:String
        self.view!.bringSubview(toFront: topLabel)
        self.view!.bringSubview(toFront: bottomLabel)
        
        if Person.shared.isRegistered
            {
            title = "login"
//            actionButton.addTarget(self, action: #selector(onLogin) ,for: .touchDown)
            }
        else
            {
            title = "continue"
//            actionButton.addTarget(self, action: #selector(onContinue) ,for: .touchDown)
            }
        let text = NSAttributedString(string: title,attributes:[.font: UIFont(name:"MuseoSans-900",size:20)!,.foregroundColor: ThemePalette.shared.dominantColor])
        actionButton.setAttributedTitle(text, for: .normal)
        actionButton.addTarget(self, action: #selector(onJump) ,for: .touchDown)
        }

    @objc func onJump()
        {
        self.performSegue(withIdentifier: "MoveToInformation", sender: self)
        }
        
    @objc func onContinue()
        {
        self.performSegue(withIdentifier: "MoveToInit", sender: self)
        }
        
    @objc func onLogin()
        {
        self.performSegue(withIdentifier: "MoveToLogin", sender: self)
        }
        
    override func didReceiveMemoryWarning() 
        {
        super.didReceiveMemoryWarning()
        }
}

