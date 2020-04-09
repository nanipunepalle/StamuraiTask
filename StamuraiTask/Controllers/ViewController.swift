//
//  ViewController.swift
//  StamuraiTask
//
//  Created by Lalith on 08/04/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var minimumRatingTextField: UITextField!
    @IBOutlet weak var maximumRatingTextField: UITextField!
    @IBOutlet weak var ratingButton: UIButton!
    var minRating: Int = 0
    var maxRating: Int = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        minPicker()
        maxPicker()
        ratingButton.layer.cornerRadius = 30
        ratingButton.titleLabel?.text = "Rating"
        minimumRatingTextField.layer.cornerRadius = 30
        maximumRatingTextField.layer.cornerRadius = 30
    }
//    onta
    
    @IBAction func ratingButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "HomeToRating", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let error = validateFields()
        if error != nil{
            showAlert(err: error!)
        }
        else{
        let destination = segue.destination as! RatingViewController
        let cRange: ClosedRange<Int> = minRating...maxRating
        destination.range = cRange
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}


//Picker Delegate Methods
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            minimumRatingTextField.text = "\(row)"
            minRating = row
        }
        if pickerView.tag == 2{
            
            maximumRatingTextField.text = "\(row)"
            maxRating = row
        }
        ratingButton.titleLabel?.text = "Rating \(minRating)-\(maxRating)"
    }
    
    
}

//PickerViews
extension ViewController{
    func minPicker(){
        let picker = UIPickerView()
        picker.delegate = self
        picker.tag = 1
        minimumRatingTextField.inputView = picker
    }
    func maxPicker(){
        let picker = UIPickerView()
        picker.delegate = self
        picker.tag = 2
        maximumRatingTextField.inputView = picker
    }
    func showAlert(err: String){
        let alert = UIAlertController(title: "Invalid", message: err, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style:.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }
}

extension ViewController{
    func validateFields() -> String?{
        if minimumRatingTextField.text == "" || maximumRatingTextField.text == ""{
            return "please fill all fields"
        }
        if minRating >= maxRating{
            return "invalid Minimum and Maximum Ratings"
        }
        return nil
    }
}



