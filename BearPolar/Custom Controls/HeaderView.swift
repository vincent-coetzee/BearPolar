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
        let size = self.measure()
        return(CGSize(width: UIViewNoIntrinsicMetric,height:size.height))
        }
        
    private func measure() -> CGSize
        {
        let insets = Theme.insets
        let bounds = self.bounds.insetBy(dx:insets.left,dy:0)
        let textRect = text.measureText(inWidth:bounds.size.width)
        let helpRect = helpText.measureText(inWidth:bounds.size.width)
        var height = insets.top + insets.bottom
        height += insets.top + textRect.height + helpRect.height + insets.top
        height += 16
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
        let insets = Theme.insets
        self.layer.addSublayer(text)
        text.string = self.heading
        text.font = "MuseoSans-900" as CFTypeRef
        text.fontSize = 30.0
        text.foregroundColor = UIColor.darkGray.cgColor
        let bounds = self.bounds
        var sizeRect = text.measureText(inWidth: bounds.size.width)
        text.alignmentMode = "center"
        var height = sizeRect.size.height
        text.layoutFrame = LayoutFrame(left:LayoutFrame.Edge(fraction:0,offset:insets.left),top:LayoutFrame.Edge(fraction:0,offset:insets.top),right:LayoutFrame.Edge(fraction:1,offset:-insets.right),bottom:LayoutFrame.Edge(fraction:0,offset:insets.top + height + insets.bottom))
        self.layer.addSublayer(helpText)
        text.frame = text.layoutFrame!.rectIn(rect:self.bounds)
        helpText.string = self.help
        helpText.font = helpFont.fontName as CFTypeRef
        helpText.fontSize = helpFont.pointSize
        helpText.frame = self.bounds
        helpText.foregroundColor = UIColor.darkGray.cgColor
        helpText.alignmentMode = kCAAlignmentJustified
        helpText.isWrapped = true
        sizeRect = helpText.measureText(inWidth: bounds.size.width)
        helpText.layoutFrame = LayoutFrame(left:LayoutFrame.Edge(fraction:0,offset:insets.left),top:LayoutFrame.Edge(fraction:0,offset:height),right:LayoutFrame.Edge(fraction:1,offset:-insets.right),bottom:LayoutFrame.Edge(fraction:0,offset: height + sizeRect.size.height + 48))
        helpText.frame = helpText.layoutFrame!.rectIn(rect:bounds)
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
