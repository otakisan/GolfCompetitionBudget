//
//  BudgetCalculator.swift
//  GolfCompetitionBudget
//
//  Created by takashi on 2015/01/17.
//  Copyright (c) 2015年 Takashi Ikeda. All rights reserved.
//

import UIKit

class BudgetCalculator: NSObject {
    
    func calcurate(parameter : BudgetParameter) -> Budget {
        
        // 係数を取得
        var rates = self.rates(parameter)
        
        // 全体と乗算し、個別の金額を算出
        var budgetItems : [(sectionName: String, itemName : String, rate : Double, amount: Double)] = []
        for rate in rates {
            budgetItems.append(sectionName:rate.sectionName, itemName:rate.itemName, rate:rate.rate, amount: rate.rate * Double(parameter.budgetTotalAmount))
        }
        
        // 予算セクションごとに分類し、予算データを構成
        var budget = self.compose(budgetItems)
        
        return budget
    }
    
    func rates(parameter : BudgetParameter) -> [(sectionName: String, itemName : String, rate : Double)] {
        
        let rateCelemony = parameter.celemony ? 0.4 : 0.0
        
        // 賞品
        var rateTotalAwards = 1.0 - rateCelemony
        let rateTrophy = rateTotalAwards * (parameter.trophy ? 0.1 : 0.0)
        rateTotalAwards -= rateTrophy
        
        // 特別賞
        var rateSpecialAwards = rateTotalAwards * 0.4
        let rateLowest = rateSpecialAwards * (parameter.lowest ? 0.4 : 0.0)
        let rateTotalLongest = (rateSpecialAwards - rateLowest) * 0.5
        let rateTotalClosest = rateSpecialAwards - rateLowest - rateTotalLongest
        // 誤差出るけど… 特別賞なしのときに比率がゼロになるように
        rateSpecialAwards = rateLowest + rateTotalLongest + rateTotalClosest
        
        // 順位ごとの賞品
        var rateNormalAwards = rateTotalAwards - rateSpecialAwards
        
        // 比率データ
        var rates : [(sectionName: String, itemName : String, rate : Double)] = []
        
        // 順位
        let rateBooby = rateNormalAwards / (parameter.booby ? 15 : 1)
        rateNormalAwards -= rateBooby
        var prizeRate = 1.0
        
        if parameter.golfers > 0 {
            for prizeOrder in 1...parameter.golfers {
                // ブービーを考慮しないと…
                if prizeOrder != parameter.golfers - 1 {
                    prizeRate = (rateNormalAwards * 0.3)
                    rateNormalAwards = (rateNormalAwards - prizeRate)
                    
                    rates.append(sectionName: "Prize", itemName: "Prize\(prizeOrder)", rate: Double(prizeRate))
                }
                else {
                    rates.append(sectionName: "Prize", itemName: "Booby", rate: rateBooby)
                }
            }
        }
        
        // 特別賞
        rates.append(sectionName: "Special", itemName: "Lowest", rate: rateLowest)
        
        // ドラコンとニアピンの下記の処理は汎用かできるはず
        // ドラコン
        if parameter.longest > 0 {
            let rateLongest = rateTotalLongest / Double(parameter.longest)
            for longestOrder in 1...parameter.longest {
                rates.append(sectionName: "Special", itemName: "Longest\(longestOrder)", rate: rateLongest)
            }
        }
        // ニアピン
        if parameter.closest > 0 {
            let rateClosest = rateTotalClosest / Double(parameter.closest)
            for closestOrder in 1...parameter.closest {
                rates.append(sectionName: "Special", itemName: "Closest\(closestOrder)", rate: rateClosest)
            }
        }
        
        // トロフィー
        rates.append(sectionName: "Trophy", itemName: "Trophy", rate: rateTrophy)
        
        // 表彰式
        rates.append(sectionName: "Ceremony", itemName: "Ceremony", rate: rateCelemony)
        
        return rates
    }
    
    func compose(budgetDetails : [(sectionName: String, itemName : String, rate : Double, amount: Double)]) -> Budget {
        
        var budget = Budget()
        
        // セクション名が変化したら、セクションインスタンスを生成して、配列に足す、みたいにすれば汎用化できる
        var sectionNames = ["Prize", "Special", "Trophy", "Ceremony"]
        for sectionNameInner in sectionNames {
            var eachSection = budgetDetails.filter { (sectionName, itemName, rate, amount) -> Bool in
                return sectionName == sectionNameInner
            }
            
            var bs = BudgetSection()
            bs.name = sectionNameInner
            for item in eachSection {
                var bi = BudgetItem()
                bi.name = item.itemName
                bi.amount = Int(item.amount)
                bs.items.append(bi)
            }
            
            budget.sections.append(bs)
        }
        
        return budget
    }
}
