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
        @IBOutlet weak var labelFromVC1: UILabel!
        var favouritesAdvice = ""
    
    @IBOutlet weak var saveAlarm: UILabel!
    
    @IBAction func closeFavourites(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        }
        @IBAction func saveAdviceToArray(_ sender: Any) {
        let realm = try! Realm()      //запись в realm
        try! realm.write ({
            let saveRealm = AdviceRealmFavourites()
            saveRealm.text = favouritesAdvice
            realm.add(saveRealm)
        })
            saveAlarm.isHidden = false
            saveAlarm.text = "Сохранено!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.saveAlarm.isHidden = true
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
