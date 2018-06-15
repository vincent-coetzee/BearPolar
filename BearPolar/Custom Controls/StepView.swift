//
//  StepView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/15.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
class StepView: UIView 
    {
    let innerLayer = CAShapeLayer()
    let numberLayer = CATextLayer()
    let progressLayer = CAShapeLayer()
    let backLayer = CAShapeLayer()
    var font = UIFont.applicationFont(weight: .heavy, size: 20)
    
    @IBInspectable
    var number:Int = 0
        {
        didSet
            {
            updatePaths()
            setNeedsLayout()
            }
        }
        
    @IBInspectable
    var maximum:Int = 0
        {
        didSet
            {
            updatePaths()
            setNeedsLayout()
            }
        }
        
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        initComponents()
        }
    
    required init?(coder aDecoder: NSCoder) 
        {
        super.init(coder:aDecoder)
        initComponents()
        }
        
    override func awakeFromNib()
        {
        super.awakeFromNib()
        initComponents()
        }
        
    override func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        initComponents()
        }
        
    func initComponents()
        {
        self.layer.addSublayer(backLayer)
        self.layer.addSublayer(progressLayer)
        self.layer.addSublayer(innerLayer)
        self.layer.addSublayer(numberLayer)
        numberLayer.backgroundColor = UIColor.clear.cgColor
        numberLayer.foregroundColor = UIColor.white.cgColor
        backLayer.strokeColor = UIColor.white.cgColor
        backLayer.fillColor = UIColor.white.cgColor
        backLayer.lineWidth = 12
        innerLayer.lineWidth = 12
        innerLayer.strokeColor = UIColor.black.cgColor
        innerLayer.fillColor = UIColor.black.cgColor
        progressLayer.lineWidth = 12
        progressLayer.strokeColor = UIColor.lime.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2.0,0, 0, 1)
        }
        
    func updatePaths()
        {
        let box = self.bounds.insetBy(dx: 4, dy: 4)
        let innerBox = box.insetBy(dx: 8,dy: 8)
        backLayer.path = UIBezierPath(ovalIn: box).cgPath
        progressLayer.path = UIBezierPath(ovalIn: box).cgPath
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = CGFloat(number)/CGFloat(maximum)
        innerLayer.path = UIBezierPath(ovalIn: innerBox).cgPath
        numberLayer.string = "\(number)"
        }
        
    override func layoutSubviews()
        {
        let bounds = self.bounds
        font = UIFont.applicationFont(weight: .heavy, size: bounds.insetBy(dx:12,dy:12).size.height)
        numberLayer.setUIFont(font)
        innerLayer.frame = bounds
        progressLayer.frame = bounds
        numberLayer.frame = bounds
        backLayer.frame = bounds
        let centerPoint = bounds.centerPoint
        innerLayer.position = centerPoint
        numberLayer.frame = CGRect(origin: TextWrangler.string("\(number)", centeredIn: self.bounds, usingFont: font),size: bounds.size)
        progressLayer.position = centerPoint
        backLayer.position = centerPoint
        }
}
