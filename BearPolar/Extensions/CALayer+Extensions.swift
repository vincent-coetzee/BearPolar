//
//  CALayer+Extensions.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/11.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

fileprivate var _LayoutFrameKey:String = "__LAYER_LAYOUT_KEY__"

extension CALayer
    {
    public var layoutFrame:LayoutFrame?
        {
        get
            {
            return(self.associatedObject(for: &_LayoutFrameKey) as? LayoutFrame)
            }
        set(newLayoutFrame)
            {
            self.setAssociatedObject(newLayoutFrame as Any,for: &_LayoutFrameKey)
            }
        }
        
    fileprivate func setAssociatedObject(_ object:Any,for key:inout String) 
        {
        objc_setAssociatedObject(self, &key, object, .OBJC_ASSOCIATION_RETAIN)
        }   
    
    fileprivate func associatedObject(for key:inout String) -> Any?     
        {
        return(objc_getAssociatedObject(self,&key))
        }
    }
