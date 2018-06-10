//
//  BorderLayer.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/09.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public class BorderLayer:CAShapeLayer
    {
    private var _corners = UIRectCorner()
    private var _borderEdges = UIRectEdge()
    
//    public override var corners:UIRectCorner
//        {
//        get
//            {
//            return(_corners)
//            }
//        set
//            {
//            _corners = newValue
//            makeMask()
//            setNeedsLayout()
//            setNeedsDisplay()
//            }
//        }
//        
//    public override var cornerRadius:CGFloat
//        {
//        didSet
//            {
//            makeMask()
//            setNeedsLayout()
//            setNeedsDisplay()
//            }
//        }
//        
//    public override var borderEdges:UIRectEdge
//        {
//        get
//            {
//            return(_borderEdges)
//            }
//        set
//            {
//            _borderEdges = newValue
//            makePath()
//            setNeedsLayout()
//            setNeedsDisplay()
//            }
//        }
        
//    public override var borderColor:CGColor?
//        {
//        didSet
//            {
//            super.borderColor = UIColor.clear.cgColor
//            self.strokeColor = borderColor
//            setNeedsLayout()
//            setNeedsDisplay()
//            }
//        }
//        
//    public override var borderWidth:CGFloat
//        {
//        didSet
//            {
//            super.borderWidth = borderWidth
//            self.lineWidth = borderWidth
//            setNeedsLayout()
//            setNeedsDisplay()
//            }
//        }
//        
//    override init()
//        {
//        super.init()
//        self.backgroundColor = UIColor.purple.cgColor
//        self.borderWidth = 20
//        self.borderColor = UIColor.red.cgColor
//        self.borderEdges = [.left,.top]
//        makeMask()
//        makePath()
//        }
//    
//    public override func layoutSublayers()
//        {
//        super.layoutSublayers()
//        self.makeMask()
//        self.makePath()
//        }
//        
//    private func makeMask()
//        {
//        if self.cornerRadius > 0
//            {
//            let radii = CGSize(width: self.cornerRadius, height: self.cornerRadius)
//            let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: radii)
//            let maskLayer = CAShapeLayer()
//            maskLayer.path = maskPath.cgPath
//            maskLayer.fillColor = UIColor.black.cgColor
//            self.mask = maskLayer
//            }
//        }
//        
//    private func makePath()
//        {
//        let rect = self.bounds
//        let path = UIBezierPath()
//        if self.borderEdges.contains(.top)
//            {
//            path.move(to:rect.topLeft)
//            path.addLine(to: rect.topRight)
//            }
//        if self.borderEdges.contains(.left)
//            {
//            path.move(to:rect.bottomLeft)
//            path.addLine(to: rect.topLeft)
//            }
//        if self.borderEdges.contains(.right)
//            {
//            path.move(to:rect.bottomRight)
//            path.addLine(to: rect.topRight)
//            }
//        if self.borderEdges.contains(.bottom)
//            {
//            path.move(to:rect.bottomLeft)
//            path.addLine(to: rect.bottomRight)
//            }
//        self.path = path.cgPath
//        }
//        
//    required public init?(coder aDecoder: NSCoder) 
//        {
//        fatalError("init(coder:) has not been implemented")
//        }
}
