//
//  ViewController.swift
//  MAD_Grad_karjikar_abdulla
//
//  Created by Abdulla Karjikar on 4/29/22.
//

import UIKit
import Vision
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    var image_ = UIImage(named: "LilPete.jpg")!
    
    var results_: [(String, String)] = []

    
    var rustedAcc: Float = 0.00
    var wreckedAcc: Float = 0.00
    var goodAcc: Float = 0.00
    var newAcc: Float = 0.00
    var badAcc: Float = 0.00
    
    var conditionStatus = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //print("Hello world")

        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else{
            return
        }
        
        //self.UIImageView_.image = image
        self.image_ = image
        
        guard let img = CIImage(image: image) else{
            fatalError("Error in converting image")
        }
        
        extractFeaturesAndGivePercentage{
            data in
            self.results_ = data
            // After loading all the values in a array, we are sorting based on stateName i.e. 0th element in tupple is stateName.
        }
        //detectImage(for: image)
        transitionToSellers()

    }
    
    func extractFeaturesAndGivePercentage(comp: @escaping ([(String, String)])->()){
        
        guard let img = CIImage(image: image_) else{
            fatalError("Error in converting image")
        }
        
        guard let model = try? VNCoreMLModel(for: RailroadBoxCarModelV2().model) else {
            fatalError("Loading ML model failed.....")
        }
        let req = VNCoreMLRequest(model: model, completionHandler: {[weak self] request, error in
            guard let res = request.results as? [VNClassificationObservation] else {
                fatalError("Error")
            }
            var resultLocal: [(String, String)] = []
            
            self?.conditionStatus = res.first?.identifier ?? "NIL"
            
            for ab in res{
                //print(ab.identifier, "    ", ab.confidence.magnitude)
                if ab.identifier == "good"{
                    self?.goodAcc = (ab.confidence*100).rounded()
                }
                if ab.identifier == "new"{
                    self?.newAcc = (ab.confidence*100).rounded()
                }
                if ab.identifier == "bad"{
                    self?.badAcc = (ab.confidence*100).rounded()
                }
                if ab.identifier == "rusted"{
                    self?.rustedAcc = (ab.confidence*100).rounded()
                }
                if ab.identifier == "wrecked"{
                    self?.wreckedAcc = (ab.confidence*100).rounded()
                }
                resultLocal.append((ab.identifier, String((ab.confidence*100).rounded())))

            }
            self?.results_ = resultLocal
        })

        
        let handler = VNImageRequestHandler(ciImage: img)
        
        do{
            try handler.perform([req])
        } catch {
            print("Failed to perform detection.\n")
        }
        comp(results_)
        
    }
    
    
    @IBAction func showUIImagePicker(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        present(vc, animated: true)
    }

    @IBAction func OpenCameraPicker(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func transitionToSellers() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as? ResultsViewController
        vc?.newAcc = newAcc
        vc?.goodAcc = goodAcc
        vc?.badAcc = badAcc
        vc?.rustedAcc = rustedAcc
        vc?.wreckedAcc = wreckedAcc
        
        vc?.conditionStatus = conditionStatus
        vc?.imageRailRaod_ = image_
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}




