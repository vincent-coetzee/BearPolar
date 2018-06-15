//
//  SelectableButton.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/15.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
class SelectableButton: DecoratorView,Selectable
    {
    private var textLayer = CATextLayer()
    private var alignmentH:NSTextAlignment = .left
    private var alignmentV:VerticalAlignment = .top
    
    public var font = UIFont.applicationFont(weight: .bold, size: 14)
    
    @IBOutlet var radioGroup: RadioGroup?
    
    @IBInspectable var title:String = "Button"
        {
        didSet
            {
            textLayer.string = title
            self.setNeedsDisplay()
            self.setNeedsLayout()
            }
        }
        
    @IBInspectable var fontSize:CGFloat = 14
        {
        didSet
            {
            font = UIFont.applicationFont(weight: .bold, size: fontSize)
            textLayer.setUIFont(font)
            self.setNeedsDisplay()
            self.setNeedsLayout()
            }
        }
        
    @IBInspectable var horizontalAlignment:String = "left"
        {
        didSet
            {
            switch(horizontalAlignment)
                {
            case "left":
                alignmentH = .left
            case "center":
                alignmentH = .center
            case "right":
                alignmentH = .right
            default:
                alignmentH = .left
                }
            textLayer.alignmentMode = horizontalAlignment
            self.setNeedsLayout()
            }
        }
        
    @IBInspectable var verticalAlignment:String = "top"
        {
        didSet
            {
            let aValue = VerticalAlignment(rawValue: verticalAlignment)
            if aValue == nil
                {
                return
                }
            alignmentV = aValue!
            self.setNeedsLayout()
            }
        }
        
    @IBInspectable var xInset:CGFloat = 0
        {
        didSet
            {
            self.setNeedsLayout()
            }
        }
        
    @IBInspectable var yInset:CGFloat = 0
        {
        didSet
            {
            self.setNeedsLayout()
            }
        }
        
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        initComponents()
        }
    
    required init?(coder aDecoder: NSCoder) 
        {
        super.init(coder:aDecoder)
        initComponents()
        }
    
    var isSelected: Bool = false
    
    var text:String = ""
        {
        didSet
            {
            textLayer.string = text
            setNeedsLayout()
            }
        }
        
    func select() 
        {
        isSelected = true
        self.layer.backgroundColor = UIColor.darkGoodGreen.cgColor 
        setNeedsDisplay()
        }
    
    func deselect() 
        {
        isSelected = false
        self.layer.backgroundColor = UIColor.lightGoodGreen.cgColor 
        setNeedsDisplay()
        }
        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) 
        {
        let touch = touches.first!
        let point = touch.location(in: self)
        if self.frame.contains(point)
            {
            if isSelected
                {
                radioGroup?.select(nil)
                }
            else
                {
                radioGroup?.select(self)
                }
            }
        }

    func apply(themeItem:ThemeItem)
        {
        }
        
    private func initComponents()
        {
        self.layer.addSublayer(textLayer)
        self.topOn = true
        self.bottomOn = true
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = false
//        self.layer.backgroundColor = UIColor.lightGoodGreen.cgColor
        self.layer.shadowRadius = 2.5
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width:0,height:0)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.black.cgColor
        textLayer.setUIFont(font)
        textLayer.isWrapped = true
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.foregroundColor = UIColor.white.cgColor
        }
        
    override func layoutSubviews()
        {
        super.layoutSubviews()
        let rect = TextWrangler.position(string: title, inRect: self.bounds, usingFont: font, vertical: alignmentV, horizontal: alignmentH, insetBy: CGPoint(x:xInset,y:yInset))
        textLayer.frame = rect
        }
    }
