//
//  DataAdvice.swift
//  adviceWithCoreData
//
//  Created by Тарас Евченко on 25.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class DataAdvice {
    
    static let Advice = DataAdvice()
    private init (){}
    var data : [AdviceStorage] = []
    var adviceToSave = ""
}

func saveAdvice(advice: Any) {

    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
    return
    }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "AdviceStorage", in: managedContext)!
    let saveAdvice = NSManagedObject(entity: entity, insertInto: managedContext)
    saveAdvice.setValue(DataAdvice.Advice.adviceToSave, forKeyPath: "advicesText")
    do {
        try managedContext.save()
        DataAdvice.Advice.data.append(saveAdvice as! AdviceStorage)
        print (DataAdvice.Advice.adviceToSave)
        
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

func readAdvice () {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
    return
    }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AdviceStorage")
    do {
        DataAdvice.Advice.data = try managedContext.fetch(fetchRequest) as! [AdviceStorage]
    }
        catch let error as NSError {
        print ("Could not fetch. \(error), \(error.userInfo)")
    }я
}

func deleteAdvice() -> Void {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AdviceStorage")
    let result = try? managedContext.fetch(fetchRequest)
    let resultData = result as! [AdviceStorage]
    
    for object in resultData {
        managedContext.delete(object)
    }
    
    do {
        try managedContext.save()
        print("saved!")
    } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
    } catch {
        
}
}
