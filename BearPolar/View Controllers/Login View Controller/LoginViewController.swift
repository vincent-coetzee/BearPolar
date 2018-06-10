//
//  LoginViewController.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() 
        {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        }
        
    @IBAction func onLoginTapped(_ sender:Any?)
        {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.viewControllers = [controller]
        }
}
