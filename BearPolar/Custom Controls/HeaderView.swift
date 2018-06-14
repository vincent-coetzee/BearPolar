//
//  HeadingView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/09.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
class HeaderView: UIView,Themable
    {
    private let headingLayer = CATextLayer()
    private var headingFont = UIFont.applicationFont(weight: .weight900, size: 30)
    private let helpTextLayer = CATextLayer()
    private var helpFont = UIFont.applicationFont(weight: .weight300, size: 12)
    
    public var themeEntryKey:Theme.EntryKey?
        {
        return(.header)
        }
        
    override class var layerClass:AnyClass
        {
        return(CAShapeLayer.self)
        }
        
    override var frame:CGRect
        {
        didSet
            {
            self.invalidateIntrinsicContentSize()
            }
        }
        
    override var bounds:CGRect
        {
        didSet
            {
            self.invalidateIntrinsicContentSize()
            }
        }
        
    @IBInspectable public var lineWidth:CGFloat
        {
        get
            {
            return(self.shapeLayer.lineWidth)
            }
        set(newWidth)
            {
            self.shapeLayer.lineWidth = newWidth
            }
        }
        
    private var shapeLayer:CAShapeLayer
        {
        return(self.layer as! CAShapeLayer)
        }
        
    @IBInspectable public var heading:String = ""
        {
        didSet
            {
            headingLayer.string = self.heading
            self.invalidateIntrinsicContentSize()
            setNeedsLayout()
            }
        }
        
     @IBInspectable public var help:String = ""
        {
        didSet
            {
            helpTextLayer.string = self.headingLayer
            self.invalidateIntrinsicContentSize()
            setNeedsLayout()
            }
        }
        
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        initComponents()
        }
    
    private func initComponents()
        {
        self.initBorder()
        self.initText()
        self.applyTheming()
        self.invalidateIntrinsicContentSize()
        self.setNeedsLayout()
        }
        
    required init?(coder aDecoder: NSCoder) 
        {
        super.init(coder:aDecoder)
        initComponents()
        }
    
    override var intrinsicContentSize: CGSize
        {
        let size = self.measure()
        return(CGSize(width: UIViewNoIntrinsicMetric,height:size.height))
        }
        
    private func measure() -> CGSize
        {
        let insets = Theme.insets
        let bounds = self.bounds.insetBy(dx:insets.left,dy:0)
        let headerRect = TextWrangler.measure(string: heading, usingFont: headingFont, inWidth: bounds.size.width, alignment: .center, lineBreakMode: .byWordWrapping)
        let helpRect = TextWrangler.measure(string: help, usingFont: helpFont, inWidth: bounds.size.width, alignment: .justified, lineBreakMode: .byWordWrapping)
        let height = floor(insets.top + headerRect.height + insets.top + helpRect.height + insets.bottom + 1)
        return(CGSize(width:bounds.size.width,height:height))
        }
        
    private func initBorder()
        {
        let path = UIBezierPath()
        let bounds = self.bounds
        path.move(to: bounds.topLeft)
        path.addLine(to: bounds.topRight)
        path.move(to: bounds.bottomLeft)
        path.addLine(to: bounds.bottomRight)
        let layer = self.layer as! CAShapeLayer
        layer.path = path.cgPath
        }
        
    public func apply(themeItem theme:ThemeItem)
        {
        if let headingItem = theme["heading"] as? ThemeTextItem
            {
            headingItem.apply(to: headingLayer)
            headingFont = headingItem.font
            }
        let contentItem = theme.contentItem(at: "content")
        contentItem.apply(to: self)
        theme["border"]?.apply(to: (self.layer as! CAShapeLayer))
        let helpItem = theme.textItem(at: "help")
        helpItem.apply(to: helpTextLayer)
        helpFont = helpItem.font
        helpTextLayer.alignmentMode = kCAAlignmentJustified
        helpTextLayer.isWrapped = true
        if helpItem.textColor.contrastsPoorly(with: contentItem.backgroundColor)
            {
            helpTextLayer.foregroundColor = helpItem.textColor.tweakedToContrast(against: contentItem.backgroundColor).cgColor
            }
        }
        
    private func initText()
        {
        self.layer.addSublayer(headingLayer)
        headingLayer.string = self.heading
        self.layer.addSublayer(helpTextLayer)
        helpTextLayer.string = self.help
        self.invalidateIntrinsicContentSize()
        self.setNeedsLayout()
        }
        
    override func layoutSubviews()
        {
        super.layoutSubviews()
        let insets = Theme.insets
        let bounds = self.bounds.insetBy(dx:insets.left,dy:0)
        let headerSize = TextWrangler.measure(string: heading, usingFont: headingFont, inWidth: bounds.size.width, alignment: .center, lineBreakMode: .byWordWrapping)
        let helpSize = TextWrangler.measure(string: help, usingFont: helpFont, inWidth: bounds.size.width, alignment: .justified, lineBreakMode: .byWordWrapping)
        headingLayer.frame = CGRect(x:insets.left,y:insets.top,width: bounds.size.width,height:headerSize.height)
        let top = insets.top*2 + headerSize.height
        helpTextLayer.frame = CGRect(x:insets.left,y:top,width:bounds.size.width,height:helpSize.height)
        initBorder()
        }
        
    override func awakeFromNib()
        {
        super.awakeFromNib()
        initComponents()
        }
        
    override func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        Theme.initSharedTheme(for: type(of: self))
        self.initComponents()
        }
    }
