//
//  ChoiceMatrixRow.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/15.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class ChoiceMatrixRow:UIView 
    {
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        initComponents()
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var columns:[ChoiceMatrixView.ItemType] = []
    
    public var radioGroup:RadioGroup?
        {
        didSet
            {
            for column in columns
                {
                var mutableColumn = column
                mutableColumn.radioGroup = radioGroup
                }
            }
        }
        
    public static var choiceMaker: (String) -> ChoiceMatrixView.ItemType? = { string in return(nil) }
        
    public var columnCount:Int = 2
        {
        didSet
            {
            updateColumns()
            }
        }
        
    subscript(_ column:Int) -> ChoiceMatrixView.ItemType?
        {
        get
            {
            guard column < columns.count else
                {
                return(nil)
                }
            return(columns[column])
            }
        set
            {
            guard column < columns.count,let value = newValue else
                {
                return
                }
            columns[column] = value
            }
        }
        
    private func updateColumns()
        {
        guard columns.count != columnCount else
            {
            return
            }
        if columnCount > columns.count
            {
            let extraColumns = columnCount - columns.count
            for index in 0..<extraColumns
                {
                guard let choice = ChoiceMatrixRow.choiceMaker("\(index) COL") else
                    {
                    fatalError()
                    }
                choice.translatesAutoresizingMaskIntoConstraints = false
                columns.append(choice)
                choice.backgroundColor = UIColor.red
                addSubview(choice)
                }
            }
//        defineConstraints()
        setNeedsLayout()
        }
        
    private func defineConstraints()
        {
        columns.forEach
            {
            column in
            column.removeConstraints(column.constraints)
            }
        var leftAnchor = self.leadingAnchor
        var lastColumn:UIView?
        columns.forEach
            {
            column in
            column.leadingAnchor.constraint(equalTo: leftAnchor).isActive = true
            leftAnchor = column.trailingAnchor
            column.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            column.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            lastColumn?.widthAnchor.constraint(equalTo: column.widthAnchor).isActive = true
            lastColumn = column
            }
        lastColumn?.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
    public func apply(themeItem:ThemeItem)
        {
//        for column in columns
//            {
//            column.apply(themeItem:themeItem)
//            }
        }
        
    override func layoutSubviews()
        {
        var nextColumn = columns.makeIterator()
        for frame in self.bounds.columnSlices(columnCount: columns.count)
            {
            nextColumn.next()?.frame = frame
            }
        }
        
    private func initComponents()
        {
        updateColumns()
        setNeedsLayout()
        }
    }
