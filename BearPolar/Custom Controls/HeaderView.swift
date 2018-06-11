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
    private let text = CATextLayer()
    private let helpText = CATextLayer()
    private var helpFont = UIFont.applicationFont(weight: .weight300, size: 14)
    
    public var themeKey:Theme.Key?
        {
        return(.header)
        }
        
    override class var layerClass:AnyClass
        {
        return(CAShapeLayer.self)
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
            text.string = self.heading
            setNeedsLayout()
            }
        }
        
     @IBInspectable public var help:String = ""
        {
        didSet
            {
            helpText.string = self.heading
            let bounds = self.bounds.insetBy(dx:16,dy:16)
            let rect = helpText.measureText(inWidth:bounds.size.width)
            helpText.layoutFrame = LayoutFrame(left:LayoutFrame.Edge(fraction:0,offset:16),top:LayoutFrame.Edge(fraction:0,offset:48),right:LayoutFrame.Edge(fraction:1,offset:-16),bottom:LayoutFrame.Edge(fraction:0,offset:rect.size.height + 8))
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
        self.applyTheme()
        self.setNeedsLayout()
        }
        
    required init?(coder aDecoder: NSCoder) 
        {
        super.init(coder:aDecoder)
        initComponents()
        }
    
    override var intrinsicContentSize: CGSize
        {
        let bounds = self.bounds.insetBy(dx:16,dy:16)
        let rect = helpText.measureText(inWidth:bounds.size.width)
        return(CGSize(width: UIViewNoIntrinsicMetric,height:48 + 8 + rect.size.height))
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
        
    public func applyTheme(_ theme:Theme)
        {
        theme["heading"]?.apply(to: text)
        theme["content"]?.apply(to: self)
        theme["border"]?.apply(to: (self.layer as! CAShapeLayer))
        theme["help"]?.apply(to: helpText)
        helpFont = (theme["help"] as! ThemeTextItem).font!
        }
        
    private func initText()
        {
        self.layer.addSublayer(text)
        text.string = self.heading
        text.font = "MuseoSans-900" as CFTypeRef
        text.fontSize = 30.0
        text.foregroundColor = UIColor.darkGray.cgColor
        var bounds = self.bounds.insetBy(dx:16,dy:16)
        bounds = text.measureText(inWidth: bounds.size.width)
        text.alignmentMode = "center"
        let bottom = bounds.size.height + 16
        text.layoutFrame = LayoutFrame(left:LayoutFrame.Edge(fraction:0,offset:16),top:LayoutFrame.Edge(fraction:0,offset:16),right:LayoutFrame.Edge(fraction:1,offset:-16),bottom:LayoutFrame.Edge(fraction:0,offset:bottom))
        self.layer.addSublayer(helpText)
        text.frame = text.layoutFrame!.rectIn(rect:self.bounds)
        helpText.string = self.help
        helpText.font = helpFont.fontName as CFTypeRef
        helpText.fontSize = helpFont.pointSize
        helpText.frame = self.bounds
        helpText.foregroundColor = UIColor.darkGray.cgColor
        helpText.alignmentMode = kCAAlignmentJustified
        helpText.isWrapped = true
        bounds = self.bounds.insetBy(dx:16,dy:16)
        bounds = helpText.measureText(inWidth: bounds.size.width)
        helpText.layoutFrame = LayoutFrame(left:LayoutFrame.Edge(fraction:0,offset:16),top:LayoutFrame.Edge(fraction:0,offset:bottom+8),right:LayoutFrame.Edge(fraction:1,offset:-16),bottom:LayoutFrame.Edge(fraction:0,offset: bottom + 8 + bounds.size.height + 8))
        helpText.frame = helpText.layoutFrame!.rectIn(rect:bounds)
        helpText.backgroundColor = UIColor.lime.cgColor
        self.invalidateIntrinsicContentSize()
        self.setNeedsLayout()
        }
        
    override func layoutSubviews()
        {
        super.layoutSubviews()
        let bounds = self.bounds
        text.frame = text.layoutFrame!.rectIn(rect:bounds)
        helpText.frame = helpText.layoutFrame!.rectIn(rect:bounds)
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
        ThemePalette.shared(for: type(of: self))
        self.initComponents()
        }
    }
