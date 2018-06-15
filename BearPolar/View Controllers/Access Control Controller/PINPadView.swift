//
//  PINPadView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/06.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
class PINPadView: UIView,Themable
    {
    private var keys:[KeyLayer] = []
    private var markers:[DigitMarkerLayer] = []
    private let keyEntries:[Character] = ["1","2","3","4","5","6","7","8","9"," ","0","⌫"]
    private var pin = PIN()
    
    private static let KeySpacing:CGFloat = 20
    private static var DigitMarkerDiameter:CGFloat = 20
    private static var DigitMarkerKeySpacing:CGFloat = 30
    private static let KeyPressAnimationDuration:CFTimeInterval = 0.3
    
    typealias TextAttributes = [NSAttributedStringKey:Any]
    
    public var themeEntryKey:Theme.EntryKey?
        {
        return(.pinPad)
        }
        
    public var PINEntryCompletion: (PINPadView,PIN) -> () = { view,pin in }
    
    private class KeyLayer:CALayer
        {
        let circle:CAShapeLayer = CAShapeLayer()
        let text:CATextLayer = CATextLayer()
        let entry:Character
        let filled:Bool
        
        var textColor:UIColor = UIColor.black
        var fillColor:UIColor = UIColor.lightGray
        
        var themeKey:String
            {
            return("keys")
            }
            
        var font:UIFont = UIFont.systemFont(ofSize: 20)
            {
            didSet
                {
                text.font = font.fontName as CFTypeRef
                text.fontSize = font.pointSize
                setNeedsLayout()
                }
            }
            
        init(entry:Character,filled:Bool = true)
            {
            self.filled = filled
            self.entry = entry
            super.init()
            self.text.string = "\(entry)"
            defineKey()
            }
            
        required init?(coder aDecoder: NSCoder) 
            {
            fatalError("init(coder:) has not been implemented")
            }
            
        private func defineKey()
            {
            addSublayer(circle)
            addSublayer(text)
            text.foregroundColor = textColor.cgColor
            text.font = font.fontName as CFTypeRef
            text.fontSize = font.pointSize 
            circle.fillColor = filled ? fillColor.cgColor : UIColor.clear.cgColor
            }
            
        public override func layoutSublayers()
            {
            super.layoutSublayers()
            let layerBounds = self.bounds
            circle.bounds = layerBounds
            let textSize = (text.string as! NSString).size(withAttributes: [.font: font])
            text.bounds = CGRect(origin: .zero,size: textSize)
            let centerPoint = layerBounds.centerPoint
            circle.position = centerPoint
            text.position = centerPoint
            circle.path = UIBezierPath(ovalIn: layerBounds).cgPath
            }
        }
        
    private class DigitMarkerLayer:CAShapeLayer
        {
        var themeKey = "digits"
            
        override init()
            {
            super.init()
            self.strokeColor = UIColor.red.cgColor
            self.lineWidth = 2
            self.fillColor = UIColor.clear.cgColor
            setNeedsLayout()
            }
        
        override init(layer: Any)
            {
            let incoming = layer as! DigitMarkerLayer
            super.init(layer: incoming)
            setNeedsLayout()
            }
            
        required init?(coder aDecoder: NSCoder) 
            {
            fatalError("init(coder:) has not been implemented")
            }
        
        override func layoutSublayers()
            {
            super.layoutSublayers()
            let theseBounds = self.bounds
            let diameter = min(theseBounds.size.width,theseBounds.size.height)
            self.path = UIBezierPath(ovalIn: CGRect(origin: .zero,size: CGSize(width: diameter,height: diameter))).cgPath
            }
            
        func mark(entered: Bool)
            {
            self.fillColor = entered ? self.strokeColor : UIColor.clear.cgColor
            setNeedsDisplay()
            }
        }
        
    public func reset()
        {
        pin = PIN()
        for marker in markers
            {
            marker.mark(entered:false)
            }
        }
        
    public override func awakeFromNib()
        {
        super.awakeFromNib()
        initComponents()
        self.applyTheming()
        setNeedsLayout()
        }
        
    func apply(themeItem theme:ThemeItem)
        {
        theme["view"]?.apply(to: self)
        let border = theme["digits.border"] as! ThemeBorderItem
        for marker in markers
            {
            marker.strokeColor = border.borderColor.cgColor
            marker.lineWidth = border.borderWidth
            }
        let text = theme["keys.text"] as! ThemeTextItem
        let content = theme["keys.content"] as! ThemeContentItem
        for key in keys
            {
            key.font = text.font
            key.text.foregroundColor = text.textColor.cgColor
            key.backgroundColor = content.backgroundColor.cgColor
            key.circle.fillColor = key.filled ? content.contentColor?.cgColor : UIColor.clear.cgColor
            key.setNeedsLayout()
            }
        setNeedsLayout()
        }
        
    private func initComponents()
        {
        self.backgroundColor = UIColor.clear
        let textAttributes:TextAttributes = [.font: UIFont.systemFont(ofSize:10),.foregroundColor: UIColor.black]
        var index = 0
        for keyEntry in keyEntries
            {
            makeKeyLayer(for: keyEntry,textAttributes: textAttributes,filled: index != 9)
            index += 1
            }
        for _ in 0..<PIN.standardPINLength
            {
            makeDigitMarkerLayer()
            }
        setNeedsLayout()
        }
        
    private func makeDigitMarkerLayer()
        {
        let markerLayer = DigitMarkerLayer()
        markers.append(markerLayer)
        self.layer.addSublayer(markerLayer)
        }
        
    private func makeKeyLayer(for keyText:Character,textAttributes:TextAttributes,filled:Bool = true)
        {
        let keyLayer = KeyLayer(entry: keyText,filled:filled)
        keys.append(keyLayer)
        self.layer.addSublayer(keyLayer)
        }
        
    public override func layoutSubviews()
        {
        super.layoutSubviews()
        let viewBounds = self.bounds
        let spacing = (viewBounds.size.width - CGFloat(PIN.standardPINLength)*PINPadView.DigitMarkerDiameter) / CGFloat(PIN.standardPINLength - 1)
        var box = CGRect(origin: .zero,size: CGSize(width: PINPadView.DigitMarkerDiameter,height: PINPadView.DigitMarkerDiameter))
        for marker in markers
            {
            marker.frame = box
            marker.setNeedsLayout()
            box.origin.x += (box.size.width + spacing)
            }
        box.origin.x = 0
        box.origin.y += (PINPadView.DigitMarkerDiameter + PINPadView.DigitMarkerKeySpacing)
        let width = (viewBounds.size.width - 2*PINPadView.KeySpacing) / 3.0
        let height = (viewBounds.size.height - box.origin.y - 3.0*PINPadView.KeySpacing) / 4.0
        box.size.height = min(width,height)
        box.size.width = box.size.height
        let keySpacingX = (viewBounds.size.width - 3*box.size.width) / 2.0
        var index = 0
        for key in keys
            {
            key.frame = box
            key.setNeedsLayout()
            box.origin.x += (box.size.width + keySpacingX)
            index += 1
            if index % 3 == 0
                {
                box.origin.x = 0
                box.origin.y += (box.size.height + PINPadView.KeySpacing)
                }
            }
        }
        
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) 
        {
        guard let point = touches.first?.location(in: self) else
            {
            return
            }
        for key in keys
            {
            if key.frame.contains(point)
                {
                let entry = key.entry
                if entry == "⌫"
                    {
                    if pin.count > 0
                        {
                        markers[pin.count - 1].mark(entered: false)
                        pin.dropLastDigit()
                        }
                    }
                else if entry == " "
                    {
                    break
                    }
                else
                    {
                    if pin.count < PIN.standardPINLength
                        {
                        let marker = markers[pin.count]
                        animateEntry(entry,from: key,to: marker)
                        pin.appendDigit(entry)
                        }
                    }
                }
            }
        }
        
    private func animateEntry(_ entry:Character,from: KeyLayer,to: DigitMarkerLayer)
        {
        let textLayer = CATextLayer()
        textLayer.position = from.position
        textLayer.bounds = from.text.bounds
        textLayer.string = from.text.string
        textLayer.font = from.text.font
        textLayer.fontSize = from.text.fontSize
        textLayer.foregroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.layer.addSublayer(textLayer)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setAnimationDuration(PINPadView.KeyPressAnimationDuration)
        CATransaction.setCompletionBlock
            {
            textLayer.removeFromSuperlayer()
            to.mark(entered: true)
            if self.pin.isComplete 
                {
                self.PINEntryCompletion(self,self.pin)
                }
            }
        let movement = CABasicAnimation(keyPath: "position")
        movement.toValue = to.position
        movement.fromValue = from.position
        movement.isRemovedOnCompletion = true
        textLayer.add(movement, forKey: nil)
        textLayer.setValue(to.position,forKey:"position")
        let resizing = CABasicAnimation(keyPath: "transform")
        let xFactor = to.bounds.size.height / from.bounds.size.height
        let yFactor = to.bounds.size.width / from.bounds.size.height
        resizing.toValue = CATransform3DMakeScale(xFactor,yFactor,1)
        resizing.fromValue = CATransform3DIdentity
        resizing.isRemovedOnCompletion = true
        textLayer.add(resizing, forKey: nil)
        textLayer.setValue(CATransform3DMakeScale(xFactor,yFactor,1),forKey:"transform")
        let coloring = CABasicAnimation(keyPath: "foregroundColor")
        coloring.toValue = markers.first!.borderColor
        coloring.fromValue = keys.first!.text.foregroundColor
        coloring.isRemovedOnCompletion = true
        textLayer.add(coloring, forKey: nil)
        textLayer.setValue(coloring.toValue,forKey:"foregroundColor")
        CATransaction.commit()
        }
        
    override func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        Theme.initSharedTheme(for: type(of: self))
        initComponents()
        applyTheming()
        self.setNeedsLayout()
        }
    }
