//
//  File.swift
//  GolfCompetitionBudget
//
//  Created by takashi on 2015/01/18.
//  Copyright (c) 2015年 Takashi Ikeda. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(args : [CVarArgType]) -> String {
        return String(format: self.localized(), arguments: args)
    }
    
    func toFloat() -> Float {
        return (self as NSString).floatValue
    }
    
    func toFloatToInt() -> Int? {
        return String(format: "%.0f", self.toFloat()).toInt()
    }
    
    func splitAlphaAndDigit() -> (alphabet : String, digit : String) {

        var regex = NSRegularExpression(pattern: "([a-zA-Z]*)([0-9]*)", options: NSRegularExpressionOptions.CaseInsensitive, error: nil)
        
        var match = regex?.firstMatchInString(self, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, (self as NSString).length))
        
        var matches = regex?.matchesInString(self, options: NSMatchingOptions.allZeros, range: NSMakeRange(0, (self as NSString).length))
        
        var al = ""
        if let matchAl = match {
            if matchAl.numberOfRanges >= 2 {
                al = (self as NSString).substringWithRange(matchAl.rangeAtIndex(1))
            }
        }
        var dg = ""
        if let matchDg = match {
            if matchDg.numberOfRanges >= 3 {
                dg = (self as NSString).substringWithRange(matchDg.rangeAtIndex(2))
            }
        }
        
        
        return (al, dg)
    }
}
