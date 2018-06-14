//
//  LabeledButtonView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
class LabeledButtonView: LabeledHolderView
    {
    @IBInspectable
    var buttonText:String = ""
        {
        didSet
            {
            self.buttonAttributedText = NSAttributedString(string:buttonText,attributes:UIFont.attributesWithFont(weight: .weight700, size: 24,color:UIColor.darkGray))
            }
        }
        
    var buttonAttributedText:NSAttributedString = NSAttributedString(string: "")
        {
        didSet
            {
            (childView as! UIButton).setAttributedTitle(buttonAttributedText,for: .normal)
            adjustButtonPosition()
            }
        }
        
    override func initComponents()
        {
        super.initComponents()
        let button = UIButton(frame:.zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lime
        addChildView(button)
        adjustButtonPosition()
        setNeedsLayout()
        }
        
    func adjustButtonPosition()
        {
        let button = childView as! UIButton
        if let text = button.attributedTitle(for: .normal)
            {
            var size = text.size()
            size.width += 48
            let layoutFrame = LayoutFrame(left: LayoutFrame.Edge(fraction:1.0,offset:-size.width),top:LayoutFrame.Edge(fraction:0,offset:12),right:LayoutFrame.Edge(fraction:1,offset:-size.width+12),bottom:LayoutFrame.Edge(fraction:1.0,offset:-12))
            button.layoutFrame = layoutFrame
            }
        }
    }
