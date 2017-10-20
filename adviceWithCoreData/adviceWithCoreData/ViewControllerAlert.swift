//
//  ViewControllerAlertViewController.swift
//  adviceWithCoreData
//
//  Created by Тарас Евченко on 19.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import UIKit

class ViewControllerAlert: UIViewController {
    var alertAdvice = ""

    @IBAction func share(_ sender: Any) {
        let preambula = "Делюсь с тобой советом - "
        let vc = UIActivityViewController(activityItems: ([preambula]+[alertAdviceLabel.text!]), applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = self.view
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func closeAlert(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var alertAdviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (alertAdvice)
        alertAdviceLabel.text = alertAdvice
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
