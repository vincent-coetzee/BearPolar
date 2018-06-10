//
//  DigitPadView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/02.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class PINViewController: UIViewController 
    {
    @IBOutlet var messageView:UILabel!
    @IBOutlet var errorMessageView:UILabel!
    @IBOutlet var PINView:PINPadView!
    
    public var message:String = ""
        {
        didSet
            {
            messageView.text = message
            }
        }
        
    public var errorMessage:String = ""
        {
        didSet
            {
            errorMessageView.text = errorMessage
            }
        }
        
    public var PINEntryCompletion: (PINPadView,PIN) -> () = { count,pins in }
        
    public override func viewDidLoad()
        {
        super.viewDidLoad()
        PINView.PINEntryCompletion = PINEntryCompletion
        }
    }
