//
//  LabeledHolderView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class LabeledHolderView: UIView,Themable
    {
    internal var childView:UIView?
    internal var labelLayer = CATextLayer()
    internal var labelFont:UIFont = UIFont.applicationFont(weight: .weight500, size: 20)
    
    @IBOutlet var sharedColumn:TextColumn!
    
    override class var layerClass:AnyClass
        {
        return(CAShapeLayer.self)
        }
    
    public var themeEntryKey:Theme.EntryKey?
        {
        return(.textEntry)
        }
        
    @IBInspectable var labelFraction:CGFloat = 0.5
        {
        didSet
            {
            self.setNeedsLayout()
            }
        }
        
    @IBInspectable var childFraction:CGFloat = 0.25
        {
        didSet
            {
            self.setNeedsLayout()
            }
        }
        
    @IBInspectable var label:String = "Label"
        {
        didSet
            {
            labelLayer.string = label
            }
        }
        
    internal func initComponents() 
        {
        self.layer.addSublayer(labelLayer)
        labelLayer.string = label
        initBorder()
        applyTheming()
        setNeedsLayout()
    }
    
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        initComponents()
        }
        
    func apply(themeItem:ThemeItem)
        {
        themeItem.contentItem(at: "content").apply(to: self)
        themeItem.borderItem(at: "border").apply(to: (self.layer as! CAShapeLayer))
        themeItem.textItem(at: "label.text").apply(to: labelLayer)
        }
        
    func initBorder()
        {
        let path = UIBezierPath()
        let bounds = self.bounds
        path.move(to: bounds.topLeft)
        path.addLine(to: bounds.topRight)
        path.move(to: bounds.bottomLeft)
        path.addLine(to: bounds.bottomRight)
        let layer = self.layer as! CAShapeLayer
        layer.path = path.cgPath
        layer.lineWidth = 0.5
        layer.strokeColor = UIColor.lightGray.cgColor
        }
        
    override func layoutSubviews()
        {
        super.layoutSubviews()
        let size = measure()
        labelLayer.frame = CGRect(x:16,y:16.0,width: (self.bounds.size.width * labelFraction) - 16,height:size.height)
        }
    
    @discardableResult
    func measure() -> CGSize
        {
        if sharedColumn != nil
            {            
            let size = TextWrangler.measure(string: label, usingFont: labelFont, inWidth: 10000)
            sharedColumn!.share(leftOffset:16,rightOffset:size.width + 32)
            return(CGSize(width:sharedColumn!.columnWidth,height:size.height))
            }
        let width = (self.bounds.size.width * labelFraction) - 16
        let size = TextWrangler.measure(string: label, usingFont: labelFont, inWidth: width)
        return(CGSize(width:width,height:size.height))
        }
        
    public override var intrinsicContentSize:CGSize
        {
        return(CGSize(width: UIViewNoIntrinsicMetric,height: 48))
        }
        
    required init?(coder aDecoder: NSCoder) 
        {
        super.init(coder:aDecoder)
        initComponents()
        }
        
    override func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        Theme.initSharedTheme(for: type(of: self))
        initComponents()
        }
        
    func addChildView(_ childView:UIView)
        {
        self.addSubview(childView)
        self.childView = childView
        self.setNeedsLayout()
        }
}
