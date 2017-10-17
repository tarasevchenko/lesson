//
//  ViewControllerUserAdvice.swift
//  adviceWithCoreData
//
//  Created by Тарас Евченко on 16.10.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class ViewControllerUserAdvice: UIViewController {
    @IBOutlet weak var doneSaveUserAdviceAlert: UILabel!
    @IBOutlet weak var userTextAdvice: UITextField!
    
    @IBAction func saveUserAdviceButon(_ sender: UIButton) {
        let realm = try! Realm()
        if userTextAdvice.text != "" {
            try! realm.write ({
                let saveRealm = AdviceRealmFavourites()
                saveRealm.text = userTextAdvice.text!
                realm.add(saveRealm)
            })
            doneSaveUserAdviceAlert.isHidden = false //показ label
            doneSaveUserAdviceAlert.text = "Сохранено!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.doneSaveUserAdviceAlert.isHidden = true
                self.userTextAdvice.text = ""
                self.view.endEditing(true)
            })
        } else {
            doneSaveUserAdviceAlert.text = "Ошибка"

        }
       
    }
    @IBAction func closeSaveUserAdvice(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
 
    
    
    
}
