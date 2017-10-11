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
    
    @IBAction func closeFavourites(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func saveAdviceToArray(_ sender: Any) {
        let realm = try! Realm()      //запись в realm
        try! realm.write ({
            let saveRealm = AdviceRealm()
            saveRealm.text = favouritesAdvice
            realm.add(saveRealm)
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
