//
//  Dummy.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/11.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
public class BearPolarMaskedImageView:UIView
    {
    var backColorLayer:CALayer = CALayer()
    var backMask:CALayer = CALayer()
    
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        initContents()
        }
    
    required init?(coder aDecoder: NSCoder) 
        {
        super.init(coder:aDecoder)
        initContents()
        }
    
    func initContents()
        {
        self.backgroundColor = UIColor.black
        backColorLayer.backgroundColor = Theme.shared.colorPalette.primaryColor.cgColor
        self.layer.addSublayer(backColorLayer)
        let bundle = Bundle(for: type(of: self))
        backMask.contents = UIImage(named:"BearMask",in: bundle, compatibleWith: nil)?.cgImage
        backColorLayer.mask = backMask
        }
        
    override public func layoutSubviews()
        {
        super.layoutSubviews()
        backColorLayer.frame = self.bounds
        backColorLayer.mask!.frame = self.bounds
        }
        
    public override func prepareForInterfaceBuilder()
        {
        self.prepareForInterfaceBuilder()
        initContents()
        }
    }
