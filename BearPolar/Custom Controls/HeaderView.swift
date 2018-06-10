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
        return(CGSize(width: UIViewNoIntrinsicMetric,height:90))
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
        }
        
    private func initText()
        {
        self.layer.addSublayer(text)
        text.string = self.heading
        text.font = "MuseoSans-900" as CFTypeRef
        text.fontSize = 30.0
        text.frame = self.bounds
        text.foregroundColor = UIColor.darkGray.cgColor
        }
        
    override func layoutSubviews()
        {
        super.layoutSubviews()
        let attributes:[NSAttributedStringKey:Any] = [.font:UIFont(name:"MuseoSans-900",size:30)!]
        let size = (self.heading as NSString).size(withAttributes: attributes)
        text.frame = size.centeredRectInRect(self.bounds)
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
