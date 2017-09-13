//
//  viewControllerCellAdvice.swift
//  lessonOneTestButton
//
//  Created by Тарас Евченко on 12.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import Foundation
import UIKit
class   ViewControllerThree : UIViewController, UITableViewDelegate,UITableViewDataSource {
   var adviceArray = adviceShare.sharedAdvice.share
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (adviceArray.count)
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cellId = "adviceCell"
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        cell.textLabel?.text = adviceArray[indexPath.row]
        return cell
    }

}
