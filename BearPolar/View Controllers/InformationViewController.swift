//
//  InitDetailsViewController.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController 
    {
    @IBOutlet var topView:UIView!
    @IBOutlet var rightView:UIView!
    @IBOutlet var bottomView:UIView!
    @IBOutlet var leftView:UIView!

    
    override var nibName:String
        {
        return("InformationViewController")
        }
        
    override func viewDidLoad() 
        {
        super.viewDidLoad()
        }

    @IBAction func onAddMedicationTapped(_ sender:Any?)
        {
        }
        
    override func didReceiveMemoryWarning() 
        {
        super.didReceiveMemoryWarning()
        }
    }
