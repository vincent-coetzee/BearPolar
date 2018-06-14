//
//  PanelView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
public class PanelView:UIView
    {
    private let titleLabel = UILabel(frame: .zero)
    private let messageLabel = UILabel(frame: .zero)
    private let titleFont = UIFont(name:"MuseoSans-900",size:16)!
    private let messageFont = UIFont(name:"MuseoSans-500",size:12)!
    
    @IBInspectable var title:String = "Title"
        {
        didSet
            {
            update()
            }
        }
        
    @IBInspectable var message:String = "This is a small message"
        {
        didSet
            {
            update()
            }
        }
        
    @IBInspectable var buttonText = "One,Two,Three"
        {
        didSet
            {
            update()
            }
        }
        
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        initComponents()
        }
    
    required public init?(coder aDecoder: NSCoder) 
        {
        super.init(coder:aDecoder)
        initComponents()
        }
    
    fileprivate func initComponents()
        {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = titleFont
        titleLabel.text = title
        var padder = PaddingView(width:8,height:8,view:titleLabel)
        padder.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(padder)
        padder.backgroundColor = UIColor.tangerine
        padder.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        padder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        padder.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        let lastPadder = padder
        messageLabel.text = message
        messageLabel.font = messageFont
        padder = PaddingView(width:8,height:16,view:messageLabel)
        self.addSubview(padder)
        padder.translatesAutoresizingMaskIntoConstraints = false
        padder.topAnchor.constraint(equalTo: lastPadder.bottomAnchor, constant: 0).isActive = true
        padder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        padder.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        padder.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20).isActive = true
        self.setNeedsLayout()
        }
        
    fileprivate func update()
        {
        updateTitle()
        updateMessage()
        updateButtons()
        }
        
    fileprivate func updateTitle()
        {
        }
        
    fileprivate func updateMessage()
        {
        }
        
    fileprivate func updateButtons()
        {
        }
        
    override public func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        Theme.initSharedTheme(for: type(of: self))
        initComponents()
        }
        
    override public func layoutSubviews()
        {
        super.layoutSubviews()
        update()
        }
    }
