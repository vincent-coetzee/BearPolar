//
//  IdentityStageViewController.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/02.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class InitInformationViewController: UIViewController,UIAdaptivePresentationControllerDelegate,UIPopoverPresentationControllerDelegate
    {

    override func viewDidLoad() 
        {
        super.viewDidLoad()
        self.title = "Information"
        }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle 
        {
        return(.none)
        }
        
    override func didReceiveMemoryWarning() 
        {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    }
