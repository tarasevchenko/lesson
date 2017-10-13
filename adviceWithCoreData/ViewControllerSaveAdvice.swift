//
//  ViewControllerTwo.swift
//  lessonOneTestButton
//
//  Created by Тарас Евченко on 12.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift



class   ViewControllerTwo : UIViewController {
    
    var favouritesAdvice = ""
    @IBOutlet weak var labelFromVC1: UILabel!
    @IBOutlet weak var saveAlarm: UILabel!
    
    @IBAction func closeFavourites(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        }
    
    @IBAction func saveAdviceToArray(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write ({
            let saveRealm = AdviceRealmFavourites()
            saveRealm.text = favouritesAdvice
            realm.add(saveRealm)
        })
                saveAlarm.isHidden = false //показ label
                saveAlarm.text = "Сохранено!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.saveAlarm.isHidden = true // скрытие labe
            })
            
                }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            print(favouritesAdvice)
            labelFromVC1.text = favouritesAdvice
        
    }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
