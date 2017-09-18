import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var adviceButton: UIButton!
    
    @IBAction func randomButtonAdvice(_ sender: UIButton) {
    let adviceNew = adviceService()
    let adviceRandom = adviceNew.randomAdvice()
    adviceLabel.text = adviceRandom

    }
    
    @IBAction func toFavourites(_ sender: UIButton) {
        let viewControllerTwo = storyboard?.instantiateViewController(withIdentifier: "ViewControllerTwo") as! ViewControllerTwo
        viewControllerTwo.favouritesAdvice = adviceLabel.text!
        
        
        present(viewControllerTwo, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
