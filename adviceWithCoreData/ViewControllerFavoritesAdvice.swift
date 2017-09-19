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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (adviceShare.sharedAdvice.share.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "adviceCell", for: indexPath) as! MyAdviceTableViewCell
        let adviceSaves = adviceShare.sharedAdvice.share[indexPath.row]
      
        cell.myAdviceCell.text = adviceSaves.value(forKeyPath: "advicesText") as? String
        
        return cell
        
    }
       

        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
            }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AdviceStorage")
        do {
            adviceShare.sharedAdvice.share = try managedContext.fetch(fetchRequest)
        }
            
        catch let error as NSError {
        print ("Could not fetch. \(error), \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
    func  tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let viewControllerAlert = storyboard?.instantiateViewController(withIdentifier: "ViewControllerAlert") as! ViewControllerAlert 
    
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    

}
