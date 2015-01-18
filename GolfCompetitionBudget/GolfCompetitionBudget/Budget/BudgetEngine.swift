//
//  BudgetEngine.swift
//  GolfCompetitionBudget
//
//  Created by takashi on 2015/01/17.
//  Copyright (c) 2015年 Takashi Ikeda. All rights reserved.
//

import UIKit

class BudgetEngine: NSObject {
    var parameter = BudgetParameter()
    var calculator = BudgetCalculator()
    
    func calculateBudget() -> Budget {
        return self.calculator.calculate(self.parameter)
    }
}
