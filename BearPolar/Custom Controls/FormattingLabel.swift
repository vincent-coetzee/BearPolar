//
//  FormattingLabel.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/15.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

//import UIKit
//
//class FormattingLabel: UILabel 
//    {
//    public static func initWords()
//        {
//    internal struct WordFormat
//        {
//        let word:String
//        var runs:[Run] = []
//        
//        internal struct Run
//            {
//            let font:UIFont?
//            let textColor:UIColor?
//            let range:NSRange
//            
//            init(range:NSRange,font:UIFont?=nil,textColor:UIColor?=nil)
//                {
//                self.font = font
//                self.textColor = textColor
//                self.range = range
//                }
//                
//            func applyTo(string:NSMutableAttributedString)
//                {
//                if let color = self.textColor
//                    {
//                    string.addAttribute(.foregroundColor, value: color, range: range)
//                    }
//                if let aFont = self.font
//                    {
//                    string.addAttribute(.font, value: aFont, range: range)
//                    }
//                }
//            }
//        }
//    }
