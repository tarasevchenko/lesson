//
//  ViewControllerTwo.swift
//  lessonOneTestButton
//
//  Created by Тарас Евченко on 12.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class adviceShare {
    
    static let sharedAdvice = adviceShare()
    private init (){}
    var share: [NSManagedObject] = []
}

class   ViewControllerTwo : UIViewController {
        @IBOutlet weak var labelFromVC1: UILabel!
        var favouritesAdvice = ""
    var share: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
   
    print(favouritesAdvice)
        labelFromVC1.text = favouritesAdvice
       

    }

    @IBAction func closeFavourites(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    
}
    @IBAction func saveAdviceToArray(_ sender: Any) {
     
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let entity = NSEntityDescription.entity(forEntityName: "AdviceStorage", in: managedContext)!
        
        let saveAdvice = NSManagedObject(entity: entity, insertInto: managedContext)
        
        saveAdvice.setValue(favouritesAdvice, forKeyPath: "advicesText")
        
        do {
            try managedContext.save()
            adviceShare.sharedAdvice.share.append(saveAdvice)
            
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
