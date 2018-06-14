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
    
    private static let AnimationDuration:CFTimeInterval = 0.3
    
    override class var layerClass:AnyClass
        {
        return(CAShapeLayer.self)
        }
        
    @IBOutlet var keyboardController:KeyboardController!
    @IBOutlet var sharedColumn:TextColumn! = TextColumn()
    
    @IBOutlet var nextField:TextEntryView?
        {
        didSet
            {
            setNeedsLayout()
            }
        }
    
    let labelLayer = CATextLayer()
    let textValueLayer = CATextLayer()
    var labelFont:UIFont = UIFont(name:"MuseoSans-700",size:20)!
    var entryFieldFont = UIFont(name:"MuseoSans-700",size:20)!
    var highlightColor:UIColor = .clear
    var textColor:UIColor = .black
    var hasFocus:Bool = false
    var oldPosition:CGPoint = .zero
    var oldFontSize:CGFloat = 0
    var standardSize:CGFloat = 16
    var smallSize:CGFloat = 10
    var entryField:UITextField?
    var textValue:String? 
    
    public var themeEntryKey:Theme.EntryKey?
        {
        return(.textEntry)
        }
        
    @IBInspectable var label:String = "Label"
        {
        didSet
            {
            labelLayer.string = label
            self.measure()
            setNeedsLayout()
            }
        }
        
    func releaseFocus() -> Bool
        {
        return(true)
        }
        
    func didGainFocus()
        {
        startGainFocusAnimation()
        hasFocus = true
        }
        
    func didLoseFocus()
        {
        hasFocus = false
        textValue = entryField?.text
        startLoseFocusAnimation()
        }
        
    fileprivate func initComponents() 
        {
        self.layer.addSublayer(labelLayer)
        self.layer.addSublayer(textValueLayer)
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
        themeItem["content"]?.apply(to: self)
        highlightColor = (themeItem["content"] as! ThemeContentItem).highlightColor!
        themeItem["border"]?.apply(to: (self.layer as! CAShapeLayer))
        let textItem = themeItem.textItem(at: "label.text")
        textItem.apply(to: labelLayer)
        labelFont = textItem.font
        textColor = textItem.textColor
        let background = self.backgroundColor ?? .white
        if background.contrastsPoorly(with: highlightColor)
            {
            highlightColor = highlightColor.tweakedToContrast(against: background)
            }
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
        
        if hasFocus
            {
            let size = labelLayer.frame.size
            labelLayer.frame = CGRect(x:16,y:2,width:size.width,height:size.height)
            }
        else
            {
            let size = self.measure()
            labelLayer.frame = CGRect(x:sharedColumn.leftOffset,y:16.0,width:sharedColumn!.columnWidth,height:size.height)
            }
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
        keyboardController.requestFocus(field:self)
        }
        
    private func focusGainedAnimationCompleted()
        {
        labelLayer.foregroundColor = highlightColor.cgColor
        var bounds = self.bounds.insetBy(dx:16,dy:0)
        bounds.origin.y += 16
        bounds.size.height -= 20
        entryField = UITextField(frame:bounds)
        entryField!.textColor = highlightColor
        entryField!.font = labelFont
        self.addSubview(entryField!)
        entryField!.becomeFirstResponder()
        }
        
    private func focusLostAnimationCompleted()
        {
        labelLayer.foregroundColor = textColor.cgColor
        }

    private func startGainFocusAnimation()
        {
        oldPosition = labelLayer.frame.origin
        oldFontSize = labelLayer.fontSize
        var toPosition = labelLayer.frame.origin
        toPosition.y = 2
        let path = UIBezierPath()
        path.move(to: labelLayer.frame.origin)
        path.addLine(to: toPosition)
        labelLayer.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setAnimationDuration(TextEntryView.AnimationDuration)
        labelLayer.fontSize = labelLayer.fontSize
        labelLayer.frame = CGRect(origin: toPosition, size: labelLayer.frame.size)
        let movement = CAKeyframeAnimation(keyPath: "frame.origin")
        movement.path = path.cgPath
        movement.calculationMode = kCAAnimationCubicPaced
        movement.isRemovedOnCompletion = true
        movement.fillMode = kCAFillModeForwards
        labelLayer.add(movement,forKey:nil)
        let toSize:CGFloat = 10
        let fromSize = labelLayer.fontSize
        labelLayer.fontSize = toSize
        let resizing = CABasicAnimation(keyPath: "fontSize")
        resizing.toValue = toSize
        resizing.fromValue = fromSize
        resizing.isRemovedOnCompletion = true
        resizing.fillMode = kCAFillModeBoth
        labelLayer.add(resizing, forKey: nil)
        CATransaction.setCompletionBlock
            {
            self.focusGainedAnimationCompleted()
            }
        CATransaction.commit()
        }
        
    private func startLoseFocusAnimation()
        {
        let toPosition = oldPosition
        let fromPosition = labelLayer.frame.origin
        let path = UIBezierPath()
        path.move(to: fromPosition)
        path.addLine(to: toPosition)
        labelLayer.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setAnimationDuration(TextEntryView.AnimationDuration)
        labelLayer.fontSize = labelLayer.fontSize
        labelLayer.frame = CGRect(origin: toPosition, size: labelLayer.frame.size)
        let movement = CAKeyframeAnimation(keyPath: "frame.origin")
        movement.path = path.cgPath
        movement.calculationMode = kCAAnimationCubicPaced
        movement.isRemovedOnCompletion = true
        movement.fillMode = kCAFillModeForwards
        labelLayer.add(movement,forKey:nil)
        let toSize:CGFloat = oldFontSize
        let fromSize:CGFloat = 10
        labelLayer.fontSize = toSize
        let resizing = CABasicAnimation(keyPath: "fontSize")
        resizing.toValue = toSize
        resizing.fromValue = fromSize
        resizing.isRemovedOnCompletion = true
        resizing.fillMode = kCAFillModeBoth
        labelLayer.add(resizing, forKey: nil)
        CATransaction.setCompletionBlock
            {
            self.focusLostAnimationCompleted()
            }
        CATransaction.commit()
        let animator = UIViewPropertyAnimator(duration:TextEntryView.AnimationDuration,curve: .easeInOut)
            {
            let currentFrame = self.entryField!.frame
            var size = currentFrame.size
            let origin = CGPoint(x:self.sharedColumn.rightOffset + 32,y: currentFrame.origin.y)
            size.width -= origin.x - currentFrame.origin.x
            self.entryField!.frame = CGRect(origin: origin,size: size)
            }
        animator.addCompletion
            {
            animationState in
            self.entryField!.removeFromSuperview()
            self.entryField = nil
            }
        animator.startAnimation()
        }
        
    @discardableResult
    func measure() -> CGSize
        {
        let size = TextWrangler.measure(string: label, usingFont: labelFont, inWidth: 10000)
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
