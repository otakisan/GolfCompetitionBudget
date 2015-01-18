//
//  Budget.swift
//  GolfCompetitionBudget
//
//  Created by takashi on 2015/01/17.
//  Copyright (c) 2015年 Takashi Ikeda. All rights reserved.
//

import UIKit

class Budget: NSObject {
    lazy var sections : [BudgetSection] = []//self.testData()
    
    func toDescription() -> String {
        var description = "GolfCompetitionBudgetReportTitle".localized()
        for section in self.sections {
            description += "\n\(section.toDescription())"
        }
        
        return description
    }
    
    func testData() -> [BudgetSection] {
        var sections : [BudgetSection] = []
        var s1 = BudgetSection()
        s1.name = "section1"
        s1.items = []
        var item1 = BudgetItem()
        item1.name = "item1"
        item1.amount = 100
        s1.items.append(item1)
        sections.append(s1)
        
        return sections
    }
}
