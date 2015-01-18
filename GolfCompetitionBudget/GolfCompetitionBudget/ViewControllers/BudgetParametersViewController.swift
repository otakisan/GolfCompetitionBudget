//
//  BudgetParametersViewController.swift
//  GolfCompetitionBudget
//
//  Created by takashi on 2015/01/17.
//  Copyright (c) 2015年 Takashi Ikeda. All rights reserved.
//

import UIKit

class BudgetParametersViewController: UIViewController {

    @IBOutlet weak var budgetTotalAmountTextField: UITextField!
    @IBOutlet weak var golfersTextField: UITextField!
    @IBOutlet weak var closestTextField: UITextField!
    @IBOutlet weak var longestTextField: UITextField!
    @IBOutlet weak var lowestSwitch: UISwitch!
    @IBOutlet weak var boobySwitch: UISwitch!
    @IBOutlet weak var trophySwitch: UISwitch!
    @IBOutlet weak var ceremonySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if var destVc = segue.destinationViewController as? BudgetTableViewController {
            destVc.budget = self.calcBudget()
        }
    }
    
    func budgetParameter() -> BudgetParameter{
        var bp = BudgetParameter()
        
        // おそらく、下記の類いの処理はフレームワーク化できるはず
        bp.budgetTotalAmount = self.budgetTotalAmountTextField.text.toInt() ?? 0
        bp.golfers = self.golfersTextField.text.toInt() ?? 0
        bp.longest = self.longestTextField.text.toInt() ?? 0
        bp.closest = self.closestTextField.text.toInt() ?? 0
        bp.lowest = self.lowestSwitch.on
        bp.booby = self.boobySwitch.on
        bp.trophy = self.trophySwitch.on
        bp.celemony = self.ceremonySwitch.on
        
        return bp
    }
    
    func calcBudget() -> Budget {
        var bp = budgetParameter()
        var be = BudgetEngine()
        be.parameter = bp
        return be.calculateBudget()
    }
    

}
