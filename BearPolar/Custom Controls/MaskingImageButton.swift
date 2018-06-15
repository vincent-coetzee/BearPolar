//
//  MaskingImageButton.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/14.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
public class MaskingImageButton:UIButton
    {
    private var backColorLayer = CALayer()
    private var backMask = CALayer()
    
    @IBInspectable
    public override var tintColor:UIColor?
        {
        didSet
            {
            backColorLayer.backgroundColor = (self.tintColor ?? Theme.shared.colorPalette.primaryColor).cgColor
            }
        }
    
    @IBInspectable
    public var maskImageName:String = "Mask.ButtonDefault"
        {
        didSet
            {
            let image = Theme.shared.image(named: maskImageName)
            backMask.contents = image.cgImage
            }
        }
        
    public override init(frame:CGRect)
        {
        super.init(frame:frame)
        initComponents()
        }
    
    required public init?(coder aDecoder: NSCoder) 
        {
        super.init(coder: aDecoder)
        initComponents()
        }
    
    public override func awakeFromNib()
        {
        super.awakeFromNib()
        initComponents()
        }
        
    override public func layoutSubviews()
        {
        super.layoutSubviews()
        backColorLayer.frame = self.bounds
        backColorLayer.mask!.frame = self.bounds
        }
        
    private func initComponents()
        {
        self.backgroundColor = .clear
        backColorLayer.backgroundColor = (self.tintColor ?? Theme.shared.colorPalette.primaryColor).cgColor
        self.layer.addSublayer(backColorLayer)
        backColorLayer.mask = backMask
        }
        
    override public func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        Theme.initSharedTheme(for: type(of:self))
        initComponents()
        }
    }
