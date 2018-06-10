//
//  AlertViewController.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class AlertViewController:UIViewController 
    {
    public struct Action
        {
        let title:String
        let button:UIButton
        
        init(title:String,button:UIButton)
            {
            self.title = title
            self.button = button
            }
        }
        
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var messageLabel:UILabel!
    @IBOutlet var buttonView:UIStackView!
    
    private var actions:[Action] = []
    private var maskingView:UIView?
    
    public override var nibName:String?
        {
        return("AlertViewController")
        }
        
    var alertTitle:String = "Title"
    var alertMessage:String = "This is a short message that will appear in the alert"
        
    override func viewWillAppear(_ animated: Bool) 
        {
        let window = UIApplication.shared.delegate!.window!!
        maskingView = UIView(frame:window.bounds)
        maskingView!.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        window.addSubview(maskingView!)
        super.viewWillAppear(animated)
        }
        
    override func viewDidLoad() 
        {
        super.viewDidLoad()
        titleLabel.text = alertTitle
        messageLabel.text = alertMessage
        for action in actions
            {
            buttonView.addArrangedSubview(action.button)
            }
        self.view.layer.cornerRadius = 10
        self.view.layer.masksToBounds = true
        }
        
    func addAction(title actionTitle:String,closure: (Action) -> ())
        {
        let button = UIButton(frame:.zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        let string = NSAttributedString(string: actionTitle, attributes: [.font:UIFont(name:"MuseoSans-900",size:20)!,.foregroundColor:UIColor.tangerine])
        button.setAttributedTitle(string, for: .normal)
        let action = Action(title:actionTitle,button:button)
        actions.append(action)
        }
    }
