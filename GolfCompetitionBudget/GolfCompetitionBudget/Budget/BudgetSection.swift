//
//  BudgetSection.swift
//  GolfCompetitionBudget
//
//  Created by takashi on 2015/01/17.
//  Copyright (c) 2015年 Takashi Ikeda. All rights reserved.
//

import UIKit

class BudgetSection: NSObject {
    
    var name = "(no section)"
    var items : [BudgetItem] = []
    
    func toDescription() -> String {
        var description = "\(self.name)"
        
        for item in self.items {
            description += "\n\(item.toDescription())"
        }
        
        return description
    }
}
