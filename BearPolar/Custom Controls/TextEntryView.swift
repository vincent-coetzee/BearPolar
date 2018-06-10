//
//  TextEntryView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
class TextEntryView: UIView,Themable
    {
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
        
    @IBOutlet var field:UITextField!
    
    var fieldLabel = CATextLayer()
    var font:UIFont = UIFont(name:"MuseoSans-700",size:20)!
    
    public var themeKey:Theme.Key?
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
        
    fileprivate func initComponents() {
        field = UITextField(frame:.zero)
        addSubview(field)
        self.layer.addSublayer(fieldLabel)
        fieldLabel.string = label
        fieldLabel.font = font.fontName as CFTypeRef
        fieldLabel.fontSize = font.pointSize
        fieldLabel.foregroundColor = UIColor.lightGray.cgColor
        initBorder()
        applyTheme()
        setNeedsLayout()
    }
    
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        initComponents()
        }
        
    func applyTheme(_ theme:Theme)
        {
        theme["content"]?.apply(to: self)
        theme["border"]?.apply(to: (self.layer as! CAShapeLayer))
        theme["label.text"]?.apply(to: fieldLabel)
        theme["field.text"]?.apply(to: field)
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
        let bounds = self.bounds
        let fontSize = font.pointSize
        fieldLabel.frame = CGRect(x:fontSize,y:fontSize,width:size.width,height:size.height)
        let offset = size.width + fontSize*3
        let width = bounds.size.width - offset - fontSize
        field.frame = CGRect(x:offset,y:fontSize,width:width,height: fontSize)
        initBorder()
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
}
