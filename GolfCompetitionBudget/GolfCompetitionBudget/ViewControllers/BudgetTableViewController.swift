//
//  BudgetTableViewController.swift
//  GolfCompetitionBudget
//
//  Created by takashi on 2015/01/17.
//  Copyright (c) 2015年 Takashi Ikeda. All rights reserved.
//

import UIKit

class BudgetTableViewController: UITableViewController {
    
    var budget = Budget()
    var docInteractionController : UIDocumentInteractionController? = nil // 保持しないとクラッシュする

    @IBAction func touchInteractionButton(sender: UIBarButtonItem) {
//        interaction()
        interactionAcitivityView()
    }
    
    func budgetTextFileName() -> String {
        return "budget.txt"
    }
    
    func budgetToText() -> String {
        return self.budget.toDescription()
    }
    
    func writeBudgetToFile() -> NSURL? {
        
        // TODO: ファイルの書き出しの部分は共通化する
        
        // ドキュメントのパスへのアクセス
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        // ファイル名の宣言
        let fileName = budgetTextFileName()
        // 保存するもの
        let fileObject = budgetToText()
        // 実際の保存
        // fileObject.writeToFile(<#path: String#>, atomically: <#Bool#>, encoding: <#NSStringEncoding#>, error: <#NSErrorPointer#>)
        let fullpath = "\(documentsPath)+\(fileName)"
        let _ = try? fileObject.writeToFile(fullpath, atomically: true, encoding: NSUTF8StringEncoding)
        
        return NSURL(fileURLWithPath: fullpath)
    }
    
    func interaction() {
//        var bundle = NSBundle.mainBundle()
//        if var dataFilePath = bundle.pathForResource("AppIcon", ofType:"PNG"){
//            if let urltest = NSURL(fileURLWithPath: dataFilePath) {
//                var dicTest = UIDocumentInteractionController(URL: urltest)
//                dicTest.delegate = self
//                let ret = dicTest.presentOpenInMenuFromRect(self.view.frame, inView: self.view, animated: true)
//                if !ret {
//                    NSLog("データを開けるアプリケーションが見つかりません。", "")
//                }
//            }
//        }
        
        if let url = writeBudgetToFile() {
            NSLog(url.path!)
            self.docInteractionController = UIDocumentInteractionController(URL: url)
            self.docInteractionController?.delegate = self
            let ret = self.docInteractionController?.presentOpenInMenuFromRect(self.view.frame, inView: self.view, animated: true)
            if !(ret != nil) {
                NSLog("データを開けるアプリケーションが見つかりません。", "")
            }
        }
    }
    
    func interactionAcitivityView() {
        let text = budgetToText()
        let actItems = [text];
        
        let activityView = UIActivityViewController(activityItems: actItems, applicationActivities: nil)
        self.presentViewController(activityView, animated: true, completion: {NSLog("")})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.budget.sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.budget.sections[section].items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("defaultBudgetTableViewCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let alAndDg = self.budget.sections[indexPath.section].items[indexPath.row].name.splitAlphaAndDigit()
        cell.textLabel?.text = alAndDg.alphabet.localized() + alAndDg.digit
        cell.detailTextLabel?.text = NSString(format: self.stringFormatDependingOnLocale(), self.budget.sections[indexPath.section].items[indexPath.row].amount) as String

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.budget.sections[section].name.localized()
    }
    
    private func stringFormatDependingOnLocale() -> String {
        return NSLocale.currentLocale().localeIdentifier.lowercaseString.containsString("ja") ? "%.00f" : "%.02f"
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

extension BudgetTableViewController : UIDocumentInteractionControllerDelegate {
    
}