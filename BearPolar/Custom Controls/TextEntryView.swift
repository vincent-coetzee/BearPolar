//
//  TextEntryView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
class TextEntryView: UIView,Themable,FocusField
    {
    private static let TapAnimationDuration:CFTimeInterval = 10.0
    
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
    var highlightColor:UIColor = .clear
    var textColor:UIColor = .black
    var inStartEditingAnimation:Bool = false
    var oldFrame:CGRect = .zero
    
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
        
    func didGainFocus()
        {
        }
        
    func didLoseFocus()
        {
        startEndEditingAnimation()
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
        fieldLabel.frame = CGRect(x:16,y:16.0,width:size.width,height:size.height)
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
        if !inStartEditingAnimation
            {
            keyboardController.activeField = self
            startBeginEditingAnimation()
            }
        }
        
    private func cloneLabelField() -> CATextLayer
        {
        let copy = CATextLayer()
        copy.foregroundColor = highlightColor.cgColor
        copy.font = fieldLabel.font
        copy.fontSize = fieldLabel.fontSize
        copy.string = fieldLabel.string
        copy.frame = fieldLabel.frame
        return(copy)
        }
        
    private func startEndEditingAnimation()
        {
        inStartEditingAnimation = true
        let duration = CFTimeInterval(0.3)
        let copy = cloneLabelField()
        fieldLabel.removeFromSuperlayer()
        self.layer.addSublayer(copy)
        let toPosition = oldFrame.centerPoint
        let scaleFactor = oldFrame.size.width / fieldLabel.frame.size.width
        copy.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
            let mediaTime = CACurrentMediaTime() + 0.2
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            CATransaction.setAnimationDuration(duration)
                copy.fontSize = fieldLabel.fontSize
                let fromPosition = copy.frame.centerPoint
                let movement = CABasicAnimation(keyPath: "position")
                print("copy fromPosition = \(fromPosition) toPosition \(toPosition)")
                movement.beginTime = mediaTime + 0.1
                movement.toValue = toPosition
                movement.fromValue = fromPosition
                movement.isRemovedOnCompletion = true
                movement.fillMode = kCAFillModeBoth
                copy.add(movement,forKey:nil)
            CATransaction.setCompletionBlock
                {
                print("move ended copy.position=\(copy.position) to \(toPosition)")
                copy.setValue(toPosition,forKey:"position")
                }
            CATransaction.commit()
            copy.position = toPosition
            CATransaction.begin()
            CATransaction.setAnimationDuration(duration)
            CATransaction.setDisableActions(true)
                copy.font = fieldLabel.font
                let resizing = CABasicAnimation(keyPath: "transform")
                let toTransform = CATransform3DMakeScale(scaleFactor,scaleFactor,1)
                resizing.toValue = toTransform
                resizing.fromValue = copy.model().transform
                resizing.isRemovedOnCompletion = true
                resizing.beginTime = mediaTime
                resizing.fillMode = kCAFillModeBoth
                copy.add(resizing, forKey: nil)
                CATransaction.setCompletionBlock
                    {
                    print("size ended \(copy.position)")
                    copy.setValue(CATransform3DMakeScale(scaleFactor,scaleFactor,1),forKeyPath:"transform")
                    }
            CATransaction.commit()
            copy.transform = toTransform
            CATransaction.setCompletionBlock
            {
            print("primary ended")
            self.fieldLabel = copy
            }
        CATransaction.commit()
        }
        
    private func startBeginEditingAnimation()
        {
        inStartEditingAnimation = true
        let duration = CFTimeInterval(0.3)
        let copy = cloneLabelField()
        oldFrame = fieldLabel.frame
        fieldLabel.removeFromSuperlayer()
        self.layer.addSublayer(copy)
        let scaleFactor:CGFloat = 0.75
        let newSize = (copy.frame.size * CGPoint(x:scaleFactor,y:scaleFactor)) / 2.0
        let toPosition = CGPoint(x:8 + newSize.width,y:2+newSize.height)
        copy.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
            let mediaTime = CACurrentMediaTime() + 0.2
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            CATransaction.setAnimationDuration(duration)
                copy.fontSize = fieldLabel.fontSize
                let fromPosition = copy.frame.centerPoint
                let movement = CABasicAnimation(keyPath: "position")
                print("copy fromPosition = \(fromPosition) toPosition \(toPosition)")
                movement.beginTime = mediaTime + 0.1
                movement.toValue = toPosition
                movement.fromValue = fromPosition
                movement.isRemovedOnCompletion = true
                movement.fillMode = kCAFillModeBoth
                copy.add(movement,forKey:nil)
            CATransaction.setCompletionBlock
                {
                print("move ended copy.position=\(copy.position) to \(toPosition)")
//                copy.setValue(toPosition,forKey:"position")
                }
            CATransaction.commit()
            copy.position = toPosition
            CATransaction.begin()
            CATransaction.setAnimationDuration(duration)
            CATransaction.setDisableActions(true)
                copy.font = fieldLabel.font
                let resizing = CABasicAnimation(keyPath: "transform")
                let toTransform = CATransform3DMakeScale(scaleFactor,scaleFactor,1)
                resizing.toValue = toTransform
                resizing.fromValue = copy.model().transform
                resizing.isRemovedOnCompletion = true
                resizing.beginTime = mediaTime
                resizing.fillMode = kCAFillModeBoth
                copy.add(resizing, forKey: nil)
                CATransaction.setCompletionBlock
                    {
                    print("size ended \(copy.position)")
//                    copy.setValue(CATransform3DMakeScale(scaleFactor,scaleFactor,1),forKeyPath:"transform")
                    }
            CATransaction.commit()
            copy.transform = toTransform
            CATransaction.setCompletionBlock
            {
            print("primary ended")
//                copy.position = toPosition
//                copy.transform = CATransform3DMakeScale(scaleFactor,scaleFactor,1)
            self.fieldLabel = copy
            }
        CATransaction.commit()
        }
        
    func textAsLetters(text:String) -> [String]
        {
        var letters = [String]()
        for letter in text
            {
            letters.append(String(letter))
            }
        return(letters)
        }
        
    func letterSizes(letters:[String],font:UIFont) -> [CGSize]
        {
        var sizes:[CGSize] = []
        let attributes:[NSAttributedStringKey:Any] = [.font:font]
        for letter in letters
            {
            sizes.append(letter.size(withAttributes: attributes))
            }
        return(sizes)
        }
        
    func textLayers(startingAt:CGPoint,letters:[String],sizes:[CGSize],font:UIFont,color:UIColor) -> [CATextLayer]
        {
        var layers:[CATextLayer] = []
        let rawColor = color.cgColor
        let fontName = font.fontName
        let fontSize = font.pointSize
        var offset = startingAt
        var index = 0
        for letter in letters
            {
            let layer = CATextLayer()
            layer.contentsScale = UIScreen.main.nativeScale
            layer.foregroundColor = rawColor
            layer.string = letter
            layer.font = fontName as CFTypeRef
            layer.fontSize = fontSize
            layer.frame = CGRect(origin:offset,size:sizes[index])
            offset.x += sizes[index].width
            layers.append(layer)
            }
        return(layers)
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
