//
//  DetailViewController.swift
//  Armut
//
//  Created by Semafor Teknolojı on 4.09.2020.
//  Copyright © 2020 Semafor Teknolojı. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
   
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var proCount: UILabel!
    @IBOutlet var averageRating: UILabel!
    @IBOutlet var completedJobCount: UILabel!
    @IBOutlet var logOutAction: UIBarButtonItem!
    
   var category = String()
   var imageUrl = String()
   var prosNearCount = String()
   var rating = String()
   var jobCount = String()
    
    var viewModel: detail? {
             didSet {
               updateView()
          }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.imageFromURL(urlString:  imageUrl, PlaceHolderImage: UIImage.init(named: "placeholder")!)
        name.text = category
        proCount.text = prosNearCount
        averageRating.text = rating
        completedJobCount.text = jobCount
    }
    
    func updateView() {
        if let viewModel = viewModel {
            imageUrl = viewModel.image_url
            category = viewModel.name
            prosNearCount = String(viewModel.pro_count)
            rating = String(viewModel.average_rating)
            jobCount = String(viewModel.completed_jobs_on_last_month)
        }
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        let logIn: UserDefaults? = UserDefaults.standard
        logIn?.set(false, forKey: "isUserLoggedIn")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "page") as! PageViewController
         vc.modalPresentationStyle = .fullScreen
         self.present(vc, animated: true, completion: nil)
    }
    
}
