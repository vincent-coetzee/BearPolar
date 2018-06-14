//
//  PaddingView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public class PaddingView:UIView
    {
    private let paddingX:CGFloat
    private let paddingY:CGFloat
    private let childView:UIView
    
    init(width:CGFloat,height:CGFloat,view:UIView)
        {
        paddingX = width
        paddingY = height
        childView = view
        super.init(frame:.zero)
        addSubview(view)
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: paddingY).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: paddingY).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: paddingX).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: paddingX).isActive = true
        }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize:CGSize
        {
        var size = childView.intrinsicContentSize
        size.width += 2*paddingX
        size.height += 2*paddingY
        return(size)
        }
}
