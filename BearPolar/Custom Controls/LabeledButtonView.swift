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
    var buttonTitle:String = ""
        {
        didSet
            {
            self.buttonAttributedTitle = NSAttributedString(string: buttonTitle,attributes: textAttributes)
            }
        }
        
    var buttonAttributedTitle:NSAttributedString = NSAttributedString(string: "")
        {
        didSet
            {
            self.button.setAttributedTitle(buttonAttributedTitle,for: .normal)
            }
        }
        
    public var onTapped:(LabeledButtonView) -> () = { _ in }
    private var textAttributes:[NSAttributedStringKey:Any] = [:]
    
    private var button:UIButton
        {
        return(childView as! UIButton)
        }
        
    public override var themeEntryKey:Theme.EntryKey?
        {
        return(.labeledButton)
        }
        
    override func initComponents()
        {
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(LabeledButtonView.onButtonTapped(_:)),for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addChildView(button)
        let insets = Theme.insets
        button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true 
        super.initComponents()
        self.buttonTitle = "Button"
        setNeedsLayout()
        }
        
    override func apply(themeItem:ThemeItem)
        {
        super.apply(themeItem:themeItem)
        let textItem = themeItem.textItem(at: "button.text")
        textItem.apply(to: self.button)
        textAttributes[.font] = textItem.font
        textAttributes[.foregroundColor] = textItem.textColor
        themeItem.contentItem(at: "content").apply(to: self)
        themeItem.textItem(at: "button.text").apply(to: self.button)
        themeItem.contentItem(at: "button.content").apply(to: self.button)
        }
        
    @objc func onButtonTapped(_ sender:Any?)
        {
        self.onTapped(self)
        }
        
    override public func awakeFromNib()
        {
        super.awakeFromNib()
        initComponents()
        }
        
    override func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        Theme.initSharedTheme(for: type(of:self))
        initComponents()
        }
    }
