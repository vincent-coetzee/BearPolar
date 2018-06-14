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
    
    override class var layerClass:AnyClass
        {
        return(CAShapeLayer.self)
        }
        
    @IBOutlet var keyboardController:KeyboardController!
    
    @IBOutlet var nextField:TextEntryView?
        {
        didSet
            {
            setNeedsLayout()
            }
        }
        
    //@IBOutlet var field:UITextField!
    
    var fieldLabel = CATextLayer()
    var font:UIFont = UIFont(name:"MuseoSans-700",size:20)!
    
    public var themeEntryKey:Theme.EntryKey
        {
        return(.textEntry)
        }
        
    @IBInspectable var label:String = "Label"
        {
        didSet
            {
            fieldLabel.string = label
            }
        }
        
    internal func initComponents() 
        {
        self.layer.addSublayer(fieldLabel)
        fieldLabel.string = label
        fieldLabel.font = font.fontName as CFTypeRef
        fieldLabel.fontSize = font.pointSize
        fieldLabel.foregroundColor = UIColor.lightGray.cgColor
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
        themeItem["content"]?.apply(to: self)
        themeItem["border"]?.apply(to: (self.layer as! CAShapeLayer))
        themeItem["label.text"]?.apply(to: fieldLabel)
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
        guard let child = childView,let layoutFrame = child.layoutFrame else
            {
            return
            }
        child.frame = layoutFrame.rectIn(rect:self.bounds)
        }
    
    public override var intrinsicContentSize:CGSize
        {
        return(CGSize(width: UIViewNoIntrinsicMetric,height: 48))
        }
        
    func measure() -> CGSize
        {
        let attributes:[NSAttributedStringKey:Any] = [.font:font]
        let size = label.size(withAttributes:attributes)
        if let aField = nextField
            {
            return(size.maximum(of:aField.measure()))
            }
        return(size)
        }
        
    required init?(coder aDecoder: NSCoder) 
        {
        super.init(coder:aDecoder)
        initComponents()
        }
        
    override func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        initComponents()
        }
        
    func addChildView(_ childView:UIView)
        {
        self.addSubview(childView)
        self.childView = childView
        self.setNeedsLayout()
        }
}
