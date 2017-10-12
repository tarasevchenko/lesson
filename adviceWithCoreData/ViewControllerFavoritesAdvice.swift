//
//  viewControllerCellAdvice.swift
//  lessonOneTestButton
//
//  Created by Тарас Евченко on 12.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class   FavoritesAdvice : UIViewController, UITableViewDelegate,UITableViewDataSource {
    let realm = try! Realm()
    
    @IBAction func editAdvice(_ sender: UIButton) {
        tableView.setEditing(true, animated: false)
        tableView.reloadData()
    }
    
    @IBAction func cancelEdit(_ sender: UIButton) {
        tableView.setEditing(false, animated: false)
        tableView.reloadData()
    }
    
    
    
    
 
    @IBOutlet weak var tableView: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        tableView.allowsSelectionDuringEditing = true
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realmAdvices = realm.objects(AdviceRealmFavourites.self)
        let adviceSaves = realmAdvices.count
        return adviceSaves
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "adviceCell", for: indexPath) as! MyAdviceTableViewCell
        let realmAdvices = realm.objects(AdviceRealmFavourites.self)
        let adviceSaves = realmAdvices[indexPath.row]
        cell.myAdviceCell.text = adviceSaves.text
        
        return cell
        
    }
    
    //Нажатие на ячейку
    
        func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
            let viewControllerAlert = storyboard?.instantiateViewController(withIdentifier: "ViewControllerAlert") as! ViewControllerAlert
            let realmAdvices = realm.objects(AdviceRealmFavourites.self)
            let advicesAlert = realmAdvices[indexPath.row]
            viewControllerAlert.alertAdvice = advicesAlert.text
    
            present( viewControllerAlert, animated: true, completion: nil)
        }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
        let realmAdvices = realm.objects(AdviceRealmFavourites.self)
        let source = realmAdvices[sourceIndexPath.row].text

    try! realm.write {
        realmAdvices[sourceIndexPath.row].text = realmAdvices[destinationIndexPath.row].text
        realmAdvices[destinationIndexPath.row].text = source
    }
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete  {
            
            
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") {
            _, indexPath in
            let realmAdvices = self.realm.objects(AdviceRealmFavourites.self)
            self.realm.beginWrite()
            self.realm.delete(realmAdvices[indexPath.row])
            do {
                try! self.realm.commitWrite()
                print("Заебись")
                tableView.reloadData()
            }
        }
        
        return [deleteAction]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}





