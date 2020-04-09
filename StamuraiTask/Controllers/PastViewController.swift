//
//  PastViewController.swift
//  StamuraiTask
//
//  Created by Lalith on 08/04/20.
//  Copyright © 2020 NANI. All rights reserved.
//

import UIKit
import CoreData

class PastViewController: UIViewController {
    
    var ratings = [AllRatings]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RatingViewCell", bundle: nil), forCellReuseIdentifier: "ReuseCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
}

//Tableview delegate and datasource methods

extension PastViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseCell", for: indexPath) as! RatingViewCell
        let rating = ratings[indexPath.row]
        
        cell.ratingLabel.text = "Rating(\(rating.rating)/\(rating.maxRating))"
        
        cell.dateLabel.text = dateToString(date: rating.date!)
        //        if cell.stackView.arrangedSubviews.count != 0{
        //            removeAllSubviews(maxRange: Int(rating.maxRating), stackView: cell.stackView)
        //        }
        for i in 1...rating.maxRating{
            if i <= rating.rating{
                let starButtonView = generateStarButton(tag: Int(i), icon: "star.fill")
                cell.stackView.addArrangedSubview(starButtonView)
                
            }
            else{
                let starButtonView = generateStarButton(tag: Int(i), icon: "star")
                cell.stackView.addArrangedSubview(starButtonView)
            }
        }
        return cell
    }
}


//Function for starView and loading table view data
extension PastViewController{
    
    func loadData(){
        let fetchRequest = NSFetchRequest<AllRatings>(entityName: "AllRatings")
        do{
            ratings = try (context.fetch(fetchRequest))
        }
        catch{
            print(error)
        }
    }
    
    func generateStarButton(tag: Int,icon: String) -> UIButton {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold, scale: .large)
        let image = UIImage(systemName: icon, withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tag = tag
        button.isEnabled = false
        return button
    }
    
    func dateToString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM/yyyy HH:mm"
        let cdate = dateFormatter.string(from: date)
        return cdate
    }
}

