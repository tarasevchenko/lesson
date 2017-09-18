//
//  viewControllerCellAdvice.swift
//  lessonOneTestButton
//
//  Created by Тарас Евченко on 12.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class   ViewControllerThree : UIViewController, UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
   
    
   
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (adviceShare.sharedAdvice.share.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let adviceSaves = adviceShare.sharedAdvice.share[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "adviceCell", for: indexPath)
            //UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "adviceCell")
       
        cell.textLabel?.text = adviceSaves.value(forKeyPath: "advicesText") as? String
        
        return cell

        
   
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

}
