//
//  RatingViewController.swift
//  StamuraiTask
//
//  Created by Lalith on 08/04/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit
import CoreData

class RatingViewController: UIViewController {
    
    var range: ClosedRange<Int> = 0...5
    var userSelectedRating: Int = 0
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var submitButton: UIButton!
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        generateIcons()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        submitButton.layer.cornerRadius = 20
    }
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if count != 0{
            removeAllSubviews()
            generateIcons()
            saveData()
            count = 0
        }
        else{
            showAlert(err: "Please give rating")
        }
        
    }
}

//function for generating star views
extension RatingViewController{
    func generateIcons() {
        for i in 1...range.upperBound {
            let starButtonView = generateStarButton(tag: i, icon: "star")
            stackView.addArrangedSubview(starButtonView)
        }
    }
    @IBAction func starButtonPressed(_ sender: UIButton) {
        userSelectedRating = sender.tag
        changeState(tag: sender.tag)
        count += 1
    }
}

//function for changing state of rating
extension RatingViewController{
    func changeState(tag: Int){
        for i in 1...tag {
            let starButtonView = generateStarButton(tag: i, icon: "star.fill")
            stackView.removeArrangedSubview(stackView.viewWithTag(i)!)
            stackView.viewWithTag(i)?.removeFromSuperview()
            stackView.insertArrangedSubview(starButtonView, at: i-1)
            
        }
        if tag < range.upperBound{
            for i in tag+1...range.upperBound {
                let starButtonView = generateStarButton(tag: i, icon: "star")
                stackView.removeArrangedSubview(stackView.viewWithTag(i)!)
                stackView.viewWithTag(i)?.removeFromSuperview()
                stackView.insertArrangedSubview(starButtonView, at: i-1)
                
            }
        }
        
    }
}

//Functions for generating and removing star views
extension RatingViewController{
    func generateStarButton(tag: Int,icon: String) -> UIButton {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let image = UIImage(systemName: icon, withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tag = tag
        button.addTarget(self, action: #selector(starButtonPressed), for: .touchUpInside)
        return button
    }
    func removeAllSubviews(){
        for i in 1...range.upperBound{
            stackView.removeArrangedSubview(stackView.viewWithTag(i)!)
            stackView.viewWithTag(i)?.removeFromSuperview()
        }
    }
}


//Saving data to coreData
extension RatingViewController{
    func saveData(){
        let context = appDelegate?.persistentContainer.viewContext
        
        let newRating = AllRatings(context: context!)
        newRating.rating = Int32(userSelectedRating)
        newRating.date = Date()
        newRating.maxRating = Int32(range.upperBound)
        
        do{
            try context?.save()
        }
        catch{
            print(error)
        }
    }
    func showAlert(err: String){
        let alert = UIAlertController(title: "Invalid", message: err, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style:.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }
}
