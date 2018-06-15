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
    
    @IBOutlet var genderMatrix:ChoiceMatrixView!
    @IBOutlet var conditionMatrix:ChoiceMatrixView!
    
    @IBOutlet var genderField:UILabel!
    @IBOutlet var conditionField:UILabel!
    
    override var nibName:String
        {
        return("InformationViewController")
        }
        
    override func viewDidLoad() 
        {
        super.viewDidLoad()
        genderMatrix.onChange =
            {
            matrix,entry in
            self.genderField.text = entry
            }
        conditionMatrix.onChange =
            {
            matrix,entry in
            self.conditionField.text = entry
            }
        }

    @IBAction func onAddMedicationTapped(_ sender:Any?)
        {
        }
        
    override func didReceiveMemoryWarning() 
        {
        super.didReceiveMemoryWarning()
        }
    }
