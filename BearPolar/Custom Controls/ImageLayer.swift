//
//  ImageLayer.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public class MaskedImageLayer:CALayer
    {
    private let colorLayer = CALayer()
    private let maskLayer = CALayer()
    
    override init()
        {
        super.init()
        initComponents()
        }
    
    required public init?(coder aDecoder: NSCoder) 
        {
        fatalError("init(coder:) has not been implemented")
        }
    
    func initComponents()
        {
        self.backgroundColor = UIColor.lime.cgColor
        maskLayer.contents = UIImage(named:"BearPolygon800Mask")!
//        colorLayer.backgroundColor = UIColor.lime.cgColor
//        colorLayer.mask = maskLayer
//        colorLayer.frame = self.bounds
//        maskLayer.frame = colorLayer.bounds
//        self.addSublayer(colorLayer)
        self.mask = maskLayer
        }
        
    override public func layoutSublayers()
        {
        super.layoutSublayers()
//        colorLayer.frame = self.bounds
        maskLayer.frame = self.bounds
        }
    }
