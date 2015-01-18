//
//  BudgetItem.swift
//  GolfCompetitionBudget
//
//  Created by takashi on 2015/01/17.
//  Copyright (c) 2015年 Takashi Ikeda. All rights reserved.
//

import UIKit

class BudgetItem: NSObject {
    var name = "(no data)"
    var amount = 0
    
    func toDescription() -> String {
        return "\(self.name.splitAlphaAndDigitWithLocalized()):\(self.amount)"
    }
}
