//
//  TextEntryView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public class TextColumn:NSObject
    {
    var leftOffset:CGFloat = 0
    var rightOffset:CGFloat = 0
    
    var columnWidth:CGFloat
        {
        return(rightOffset - leftOffset)
        }
        
    func share(leftOffset:CGFloat,rightOffset:CGFloat)
        {
        if leftOffset > 0 && self.leftOffset == 0
            {
            self.leftOffset = leftOffset
            }
        else
            {
            self.leftOffset = min(self.leftOffset,leftOffset)
            }
        self.rightOffset = max(self.rightOffset,rightOffset)
        }
    }
    
@IBDesignable
class TextEntryView: UIView,Themable,FocusField
    {
    
    private static let TapAnimationDuration:CFTimeInterval = 0.3
    
    override class var layerClass:AnyClass
        {
        return(CAShapeLayer.self)
        }
        
    @IBOutlet var keyboardController:KeyboardController!
    @IBOutlet var sharedColumn:TextColumn!
    
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
    var highlightColor:UIColor = .clear
    var textColor:UIColor = .black
    var hasFocus:Bool = false
    var oldFrame:CGRect = .zero
    var fontName:String = ""
    var fontSize:CGFloat = 0
    var standardSize:CGFloat = 16
    var smallSize:CGFloat = 10
    var entryField:UITextField?
    
    public var themeKey:Theme.Key?
        {
        return(.textEntry)
        }
        
    @IBInspectable var label:String = "Label"
        {
        didSet
            {
            fieldLabel.string = label
            setNeedsLayout()
            }
        }
        
    func didGainFocus()
        {
        hasFocus = true
        let bounds = self.bounds.insetBy(dx:16,dy:8)
        entryField = UITextField(frame:bounds)
        entryField!.textColor = UIColor.coral
        entryField!.font = font
        self.addSubview(entryField!)
        }
        
    func didLoseFocus()
        {
        }
        
    fileprivate func initComponents() 
        {
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
        highlightColor = (theme["content"] as! ThemeContentItem).highlightColor!
        theme["border"]?.apply(to: (self.layer as! CAShapeLayer))
        theme["label.text"]?.apply(to: fieldLabel)
        font = (theme["label.text"] as! ThemeTextItem).font!
        fontName = font.fontName
        fontSize = font.pointSize
        textColor = (theme["label.text"] as! ThemeTextItem).textColor!
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
        fieldLabel.frame = CGRect(x:sharedColumn.leftOffset,y:16.0,width:sharedColumn!.columnWidth,height:size.height)
        let offset = size.width + fontSize*3
        let width = bounds.size.width - offset - fontSize
        //field.frame = CGRect(x:offset,y:fontSize,width:width,height: fontSize)
        initBorder()
        }
    
    public override var intrinsicContentSize:CGSize
        {
        return(CGSize(width: UIViewNoIntrinsicMetric,height: 48))
        }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) 
        {
        guard !hasFocus else
            {
            return
            }
        keyboardController.activeField = self
        startGainFocusAnimation()
        }
        
    private func cloneLabelField() -> CATextLayer
        {
        let copy = CATextLayer()
        copy.foregroundColor = highlightColor.cgColor
        copy.font = fontName as CFTypeRef
        copy.fontSize = fontSize
        copy.string = label
        copy.frame = fieldLabel.frame
        return(copy)
        }
        
    private func startLoseFocusAnimation()
        {
        let copy = cloneLabelField()
        fieldLabel.removeFromSuperlayer()
        self.layer.addSublayer(copy)
        let toPosition = oldFrame.centerPoint
        let scaleFactor = oldFrame.size.width / fieldLabel.frame.size.width
        copy.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setAnimationDuration(TextEntryView.TapAnimationDuration)
        let fromPosition = copy.frame.centerPoint
        copy.position = toPosition
        let movement = CABasicAnimation(keyPath: "position")
        movement.toValue = toPosition
        movement.fromValue = fromPosition
        movement.isRemovedOnCompletion = true
        movement.fillMode = kCAFillModeForwards
        copy.add(movement,forKey:nil)
        copy.font = fieldLabel.font
        let fromTransform = copy.transform
        let toTransform = CATransform3DMakeScale(scaleFactor,scaleFactor,1)
        copy.transform = toTransform
        let resizing = CABasicAnimation(keyPath: "transform")
        resizing.toValue = toTransform
        resizing.fromValue = fromTransform
        resizing.isRemovedOnCompletion = true
        resizing.fillMode = kCAFillModeBoth
        copy.add(resizing, forKey: nil)
        CATransaction.setCompletionBlock
            {
            self.fieldLabel = copy
            }
        CATransaction.commit()
        }
        
    private func startGainFocusAnimation()
        {
        oldFrame = fieldLabel.frame
        let copy = cloneLabelField()
        fieldLabel.removeFromSuperlayer()
        self.layer.addSublayer(copy)
        let scaleFactor = smallSize/standardSize
        let targetSize = copy.frame.size * scaleFactor
        copy.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setAnimationDuration(TextEntryView.TapAnimationDuration)
        copy.fontSize = fieldLabel.fontSize
        let fromPosition = copy.position
        var toPosition = fromPosition
        toPosition.y = 2 + targetSize.height/2.0
        toPosition.x = copy.frame.origin.x + targetSize.width/2.0
        copy.position = toPosition
        let movement = CABasicAnimation(keyPath: "position")
        movement.toValue = toPosition
        movement.fromValue = fromPosition
        movement.isRemovedOnCompletion = true
        movement.fillMode = kCAFillModeForwards
        copy.add(movement,forKey:nil)
        let toTransform = CATransform3DMakeScale(scaleFactor,scaleFactor,1)
        let fromTransform = copy.transform
        copy.transform = toTransform
        let resizing = CABasicAnimation(keyPath: "transform")
        resizing.toValue = toTransform
        resizing.fromValue = fromTransform
        resizing.isRemovedOnCompletion = true
        resizing.fillMode = kCAFillModeBoth
        copy.add(resizing, forKey: nil)
        CATransaction.setCompletionBlock
            {
            self.fieldLabel = copy
            }
        CATransaction.commit()
        }
        
    func measure() -> CGSize
        {
        let attributes:[NSAttributedStringKey:Any] = [.font:font]
        let size = label.size(withAttributes:attributes)
        if let column = sharedColumn
            {
            column.share(leftOffset:16,rightOffset:size.width + 32)
            }
        return(CGSize(width:sharedColumn!.columnWidth,height:size.height))
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
