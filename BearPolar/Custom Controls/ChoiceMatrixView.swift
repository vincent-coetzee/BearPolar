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
    private var entryThemeItem:ThemeContainerItem?
    private var entryLabels:[String] = []
    private var labelFont:UIFont = UIFont.applicationFont(weight: .medium, size: 20)
    private var rows:[ChoiceMatrixRow] = []
    private let radioGroup = RadioGroup()
    
    typealias ItemType = UIView & Selectable
    
    public var choiceMaker: (String) -> ItemType? = { a in fatalError() }
        {
        didSet
            {
            ChoiceMatrixRow.choiceMaker = choiceMaker
            }
        }
        
    public var themeEntryKey:Theme.EntryKey?
        {
        return(.choiceMatrix)
        }
        
    public var onChange: (Selectable?) -> () = { value in }
        {
        didSet
            {
            radioGroup.onChange = onChange
            }
        }
    
    subscript(row:Int,column:Int) -> ItemType?
        {
        get
            {
            guard row < rows.count else
                {
                return(nil)
                }
            return(rows[row][column])
            }
        set
            {
            guard row < rows.count,var value = newValue else
                {
                return
                }
            rows[row][column] = value
            value.radioGroup = radioGroup
            self.setNeedsLayout()
            }
        }
        
    @IBInspectable public var entryText:String = ""
        {
        didSet
            {
            entryLabels = entryText.components(separatedBy: ",")
            }
        }
        
    @IBInspectable public var rowCount:Int = 2
        {
        didSet
            {
            updateRows()
            }
        }
        
    @IBInspectable public var columnCount:Int = 2
        {
        didSet
            {
            updateColumns()
            }
        }        
        
    private func updateColumns()
        {
        for row in rows
            {
            row.columnCount = columnCount
            }
        }
        
    private func updateRows()
        {
        guard rowCount != rows.count else
            {
            return
            }
        if rowCount < rows.count
            {
            var newRows:[ChoiceMatrixRow] = []
            for rowIndex in 0..<rowCount
                {
                newRows.append(rows[rowIndex])
                }
            rows = newRows
            }
        else
            {
            let extraRowCount = rowCount - rows.count
            for _ in 0..<extraRowCount
                {
                let row = ChoiceMatrixRow(frame: CGRect(x: 0,y: 0,width: 1000,height: 1000))
                addSubview(row)
                row.translatesAutoresizingMaskIntoConstraints = false
                row.radioGroup = radioGroup
                row.columnCount = columnCount
                rows.append(row)
                }
            }
        defineConstraints()
        setNeedsLayout()
        setNeedsDisplay()
        }
    
    private func defineConstraints()
        {
        for row in rows
            {
            row.removeConstraints(row.constraints)
            }
        var lastRow:UIView?
        var topAnchor = self.topAnchor
        for row in rows
            {
            row.topAnchor.constraint(equalTo: topAnchor)
            topAnchor = row.bottomAnchor
            row.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            row.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            lastRow?.heightAnchor.constraint(equalTo: row.heightAnchor).isActive = true
            lastRow = row
            row.backgroundColor = .black
            }
        lastRow?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        if let lastRow = rows.last
            {
            lastRow.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            }
        }
        
    private func initComponents()
        {
        self.choiceMaker = 
            {
            string in
            let button = SelectableButton(frame: CGRect(x:0,y:0,width:100,height:30))
            button.text = string
            return(button)
            }
        updateRows()
        let view = UIView(frame: .zero)
        view.backgroundColor = .magenta
        self.addSubview(view)
        view.frame = CGRect(x:20,y:20,width:200,height:200)
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
        
    override func layoutSubviews()
        {
        var nextRow = rows.makeIterator()
        for frame in self.bounds.rowSlices(rowCount: rows.count)
            {
            nextRow.next()?.frame = frame
            }
        }
    
    override public func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        Theme.initSharedTheme(for: type(of:self))
        initComponents()
        }
        
    func apply(themeItem:ThemeItem)
        {
//        let item = themeItem.contentItem(at: "content")
//        item.apply(to: self)
//        entryThemeItem = themeItem.item(at: "entry")
//        let border = themeItem.borderItem(at: "border")
//        for row in rows
//            {
//            row.apply(themeItem:entryThemeItem!)
//            }
//        self.invalidateIntrinsicContentSize()
//        setNeedsLayout()
        }
    }
