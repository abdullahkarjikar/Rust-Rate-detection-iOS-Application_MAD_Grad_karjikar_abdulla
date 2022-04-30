//
//  ResultsViewController.swift
//  MAD_Grad_karjikar_abdulla
//
//  Created by Abdulla Karjikar on 4/29/22.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var UIImage_: UIImageView!
    
    var imageRailRaod_ = UIImage(named: "LilPete.jpg")!
    
    var rustedAcc: Float = 0.00
    var wreckedAcc: Float = 0.00
    var goodAcc: Float = 0.00
    var newAcc: Float = 0.00
    var badAcc: Float = 0.00
    
    var conditionStatus = ""

    @IBOutlet weak var newAccuracy: UILabel!
    @IBOutlet weak var goodAccuracy: UILabel!
    @IBOutlet weak var badAccuracy: UILabel!
    @IBOutlet weak var rustedAccuracy: UILabel!
    @IBOutlet weak var wreckedAccuracy: UILabel!
    
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newAccuracy.text = newAccuracy.text! + String(newAcc)
        goodAccuracy.text = goodAccuracy.text! + String(goodAcc)
        badAccuracy.text = badAccuracy.text! + String(badAcc)
        rustedAccuracy.text = rustedAccuracy.text! + String(rustedAcc)
        wreckedAccuracy.text = wreckedAccuracy.text! + String(wreckedAcc)
        
        conditionLabel.text = "The condition of box car is " + conditionStatus
        
        UIImage_.image = imageRailRaod_
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
