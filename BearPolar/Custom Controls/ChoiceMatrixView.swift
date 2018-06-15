//
//  ChoiceMatrixView.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/14.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
class ChoiceMatrixView: UIView,Themable
    {
    private class ChoiceEntryLayer:CALayer
        {
        public static let TextInset:CGFloat = 8
        
        private let labelLayer = CATextLayer()
        private var normalLabelFont = UIFont.applicationFont(weight: .weight500, size: 16)
        private var normalLabelColor:UIColor = .darkGray
        private var normalBackgroundColor:UIColor = .black
        private var selectedLabelColor:UIColor = .white
        private var selectedLabelFont:UIFont = UIFont.applicationFont(weight: .weight700, size: 16)
        private var selectedBackgroundColor:UIColor = .black
        
        fileprivate var isSelected:Bool = false
            {
            didSet
                {
                self.updateState()
                }
            }
            
        var entryLabel:String = "Entry"
            {
            didSet
                {
                labelLayer.string = entryLabel
                }
            }
            
        init(label:String)
            {
            super.init()
            initComponents()
            labelLayer.string = label
            self.entryLabel = label
            }
            
        override init(layer:Any)
            {
            super.init(layer:layer)
            self.entryLabel = ""
            initComponents()
            }
        
        private func updateState()
            {
            if isSelected
                {
                labelLayer.setUIFont(selectedLabelFont)
                labelLayer.foregroundColor = selectedLabelColor.cgColor
                self.backgroundColor = selectedBackgroundColor.cgColor
//                self.shadowColor = UIColor.black.cgColor
//                self.shadowOffset = CGSize.zero
//                self.shadowRadius = 6
//                self.shadowOpacity = 0.8
                }
            else
                {
                labelLayer.setUIFont(normalLabelFont)
                labelLayer.foregroundColor = normalLabelColor.cgColor
                self.backgroundColor = normalBackgroundColor.cgColor
//                self.shadowOpacity = 0.0
                }
            self.setNeedsDisplay()
            }
        required init?(coder aDecoder: NSCoder) 
            {
            fatalError("init(coder:) has not been implemented")
            }
            
        private func initComponents()
            {
            self.addSublayer(labelLayer)
            setNeedsLayout()
            }
            
        override func layoutSublayers()
            {
            super.layoutSublayers()
            let bounds = self.bounds
            let labelSize = TextWrangler.measure(string: entryLabel, usingFont: selectedLabelFont, inWidth: 10000)
            let sizeX = bounds.size.width - 2.0*ChoiceEntryLayer.TextInset
            let originX = ChoiceEntryLayer.TextInset
            let originY = (bounds.size.height - labelSize.height)/2.0
            labelLayer.frame = CGRect(x: originX,y: originY, width: sizeX,height: labelSize.height)
            }
            
        func apply(themeItem:ThemeItem)
            {
            var container = themeItem.containerItem(at: "normal")
            var textItem = container.textItem(at: "text")
            normalLabelColor = textItem.textColor
            normalLabelFont = textItem.font
            var contentItem = container.contentItem(at: "content")
            normalBackgroundColor = contentItem.backgroundColor
            container = themeItem.containerItem(at: "selection")
            textItem = container.textItem(at: "text")
            selectedLabelColor = textItem.textColor
            selectedLabelFont = textItem.font
            contentItem = container.contentItem(at: "content")
            selectedBackgroundColor = contentItem.backgroundColor
            updateState()
            setNeedsLayout()
            }
        }
        
    private var entryThemeItem:ThemeContainerItem?
    private var entries:[ChoiceEntryLayer] = []
    private var entryLabels:[String] = []
    private var labelFont:UIFont = UIFont.applicationFont(weight: .weight500, size: 20)
    
    public var themeEntryKey:Theme.EntryKey?
        {
        return(.choiceMatrix)
        }
        
    public var onChange: (ChoiceMatrixView,String?) -> () = { a,b in }
    
    @IBInspectable
    public var entryText:String = ""
        {
        didSet
            {
            for entry in entries
                {
                entry.removeFromSuperlayer()
                }
            entries = []
            entryLabels = entryText.components(separatedBy: ",")
            for label in entryLabels
                {
                let entry = ChoiceEntryLayer(label:label)
                self.layer.addSublayer(entry)
                entries.append(entry)
                if let item = entryThemeItem
                    {
                    entry.apply(themeItem: item)
                    }
                }
            self.selectedEntry = entries.first
            self.invalidateIntrinsicContentSize()
            setNeedsLayout()
            }
        }
        
    private var selectedEntry:ChoiceEntryLayer?
        {
        willSet
            {
            selectedEntry?.isSelected = false
            }
        didSet
            {
            selectedEntry?.isSelected = true
            onChange(self,selectedEntry?.entryLabel)
            }
        }
    
    public override func layoutSubviews()
        {
        super.layoutSubviews()
        let bounds = self.bounds
        var frame = CGRect(x:0,y:0,width:bounds.size.width,height: bounds.size.height / CGFloat(entries.count))
        for entry in entries
            {
            entry.frame = frame.insetBy(dx: 2, dy: 2)
            frame.origin.y += frame.size.height
            }
        }
        
    private func measure() -> CGSize
        {
        var totalHeight:CGFloat = 0
        for label in entryLabels
            {
            var labelSize = TextWrangler.measure(string: label, usingFont: labelFont, inWidth: 10000)
            labelSize.height += (2.0 * ChoiceEntryLayer.TextInset)
            totalHeight += labelSize.height
            }
        let bounds = self.bounds
        return(CGSize(width: bounds.size.width,height:totalHeight))
        }
        
    public override var intrinsicContentSize:CGSize
        {
        let size = measure()
        return(CGSize(width: 300.0,height: size.height))
        }
        
    private func initComponents()
        {
        applyTheming()
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
    
    override public func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        Theme.initSharedTheme(for: type(of:self))
        initComponents()
        }
        
    func apply(themeItem:ThemeItem)
        {
        let item = themeItem.contentItem(at: "content")
        item.apply(to: self)
        entryThemeItem = themeItem.item(at: "entry")
        let border = themeItem.borderItem(at: "border")
        let radius = border.radius!
        self.layer.cornerRadius = radius
        labelFont = entryThemeItem!.textItem(at: "selection.text").font
        for entry in entries
            {
            entry.apply(themeItem: entryThemeItem!)
            entry.cornerRadius = radius
            entry.setNeedsLayout()
            }
        self.invalidateIntrinsicContentSize()
        setNeedsLayout()
        }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) 
        {
        let touch = touches.first!
        let point = touch.location(in: self)
        for entry in entries
            {
            if entry.frame.contains(point)
                {
                selectedEntry = entry
                return
                }
            }
        }
    }
