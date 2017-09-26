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

class   FavoritesAdvice : UIViewController, UITableViewDelegate,UITableViewDataSource {
    
   
    @IBOutlet weak var tableView: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readAdvice()
        tableView.reloadData()
        tableView.allowsSelectionDuringEditing = true
        tableView.setEditing(true, animated: false)
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (DataAdvice.Advice.data.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "adviceCell", for: indexPath) as! MyAdviceTableViewCell
        let adviceSaves = DataAdvice.Advice.data[indexPath.row]
        cell.myAdviceCell.text = adviceSaves.value(forKeyPath: "advicesText") as? String
        
        return cell
        
    }
    
    //Нажатие на ячейку
    
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let viewControllerAlert = storyboard?.instantiateViewController(withIdentifier: "ViewControllerAlert") as! ViewControllerAlert
        let adviceAlerts = DataAdvice.Advice.data[indexPath.row]
        let advicesAlert = adviceAlerts.value(forKeyPath: "advicesText") as? String
        viewControllerAlert.alertAdvice = advicesAlert!
        
        present( viewControllerAlert, animated: true, completion: nil)
    }
    
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let source = DataAdvice.Advice.data[sourceIndexPath.row]
            DataAdvice.Advice.data[sourceIndexPath.row] = DataAdvice.Advice.data[destinationIndexPath.row]
            DataAdvice.Advice.data[destinationIndexPath.row] = source
            
    }
            func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
                return .delete
            }
    
            func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete  {
            

                }
    }
    
    
    
    //
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") {
            _, indexPath in
            DataAdvice.Advice.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            deleteAdvice()
        }
        
        return [deleteAction]
    }
      //
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    



}
