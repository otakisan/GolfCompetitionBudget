//
//  BudgetParametersViewController.swift
//  GolfCompetitionBudget
//
//  Created by takashi on 2015/01/17.
//  Copyright (c) 2015年 Takashi Ikeda. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BudgetParametersViewController: UIViewController {

    @IBOutlet weak var budgetTotalAmountTextField: UITextField!
    @IBOutlet weak var golfersTextField: UITextField!
    @IBOutlet weak var closestTextField: UITextField!
    @IBOutlet weak var longestTextField: UITextField!
    @IBOutlet weak var lowestSwitch: UISwitch!
    @IBOutlet weak var boobySwitch: UISwitch!
    @IBOutlet weak var trophySwitch: UISwitch!
    @IBOutlet weak var ceremonySwitch: UISwitch!
    
    var isShowAd = false
    var interstitial : GADInterstitial?

    @IBAction func unwindFromBudgetTableViewController(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loadAd()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showAd()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destVc = segue.destinationViewController as? BudgetTableViewController {
            destVc.budget = self.calcBudget()
            self.isShowAd = true
        }
    }
    
    func budgetParameter() -> BudgetParameter{
        let bp = BudgetParameter()
        
        // おそらく、下記の類いの処理はフレームワーク化できるはず
        bp.budgetTotalAmount = Int(self.budgetTotalAmountTextField.text ?? "0") ?? 0
        bp.golfers = Int(self.golfersTextField.text ?? "0") ?? 0
        bp.longest = Int(self.longestTextField.text ?? "0") ?? 0
        bp.closest = Int(self.closestTextField.text ?? "0") ?? 0
        bp.lowest = self.lowestSwitch.on
        bp.booby = self.boobySwitch.on
        bp.trophy = self.trophySwitch.on
        bp.celemony = self.ceremonySwitch.on
        
        return bp
    }
    
    func calcBudget() -> Budget {
        let bp = budgetParameter()
        let be = BudgetEngine()
        be.parameter = bp
        return be.calculateBudget()
    }

    private func loadAd() {
        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3119454746977531/1767548801")
        let gadRequest = GADRequest()
        self.interstitial?.loadRequest(gadRequest)
        self.interstitial?.delegate = self
    }

    private func showAd() {
        if self.isShowAd && self.interstitial!.isReady {
            self.interstitial?.presentFromRootViewController(self)
        }
    }
}

extension BudgetParametersViewController : GADInterstitialDelegate {
    func interstitialDidDismissScreen(ad: GADInterstitial!){
        self.loadAd()
    }
    
    func interstitialWillPresentScreen(ad: GADInterstitial!) {
        self.isShowAd = false
    }
    
    func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!){
        print(error)
    }
}