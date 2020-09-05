//
//  HomeViewController.swift
//  Armut
//
//  Created by Semafor Teknolojı on 4.09.2020.
//  Copyright © 2020 Semafor Teknolojı. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var trending = [categories]()
    var other = [categories]()
    var post = [posts]()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet var trendingCollectionView: UICollectionView!
    @IBOutlet var otherCollectionView: UICollectionView!
    @IBOutlet var blogCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        if !CheckInternet.Connection(){
            self.Alert(Message: "Your Device is not connected with internet!")
        }else{
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.style = UIActivityIndicatorView.Style.gray
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
            
            NetworkingService.shared.getServicesInformation() { (trends,others,posts, error) in
                  DispatchQueue.main.async {
                    self.trending = trends
                    self.other = others
                    self.post = posts
                    
                    if self.trending.count != 0 || self.other.count != 0 || self.post.count != 0{
                        self.trendingCollectionView.dataSource = self
                        self.trendingCollectionView.delegate = self
                        self.trendingCollectionView.reloadData()
                        
                        self.otherCollectionView.dataSource = self
                        self.otherCollectionView.delegate = self
                        self.otherCollectionView.reloadData()
                        
                        self.blogCollectionView.dataSource = self
                        self.blogCollectionView.delegate = self
                        self.blogCollectionView.reloadData()
                    }
                    else{
                       let errorString = error?.localizedDescription ?? "An error has occurred!Restaurants informations could not be fetched!"
                       self.Alert(Message: errorString)
                    }
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.hidesWhenStopped = true
                     
                  }
              }
        }
    }
    
    func addNavBarImage(){
        let navcontroller = navigationController!
        
        let image = #imageLiteral(resourceName: "armut-logo-color")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navcontroller.navigationBar.frame.size.width-3
        let bannerHeight = navcontroller.navigationBar.frame.size.height-20
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    
    func Alert (Message: String){
        let alert = UIAlertController(title: "", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            return trending.count
        }
        if collectionView.tag == 1{
            return other.count
        }
        if collectionView.tag == 2{
            return post.count
        }
       return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as! TrendingCollectionViewCell
        cell.imageView.layer.masksToBounds = true
        cell.imageView.layer.cornerRadius = 10
        if collectionView.tag == 0{
            cell.imageView.imageFromURL(urlString:  trending[indexPath.row].image_url, PlaceHolderImage: UIImage.init(named: "placeholder")!)
            cell.categoryName.text = trending[indexPath.row].name
            cell.categoryDetail.text = String(trending[indexPath.row].pro_count) + " Pros near you"
        }
        if collectionView.tag == 1{
            cell.imageView.imageFromURL(urlString:  other[indexPath.row].image_url, PlaceHolderImage: UIImage.init(named: "placeholder")!)
            cell.categoryName.text = other[indexPath.row].name
            cell.categoryDetail.text = String(other[indexPath.row].pro_count) + " Pros near you"
        }
        if collectionView.tag == 2{
            cell.imageView.imageFromURL(urlString:  post[indexPath.row].image_url, PlaceHolderImage: UIImage.init(named: "placeholder")!)
            cell.categoryName.text = post[indexPath.row].title
            cell.categoryDetail.text = post[indexPath.row].category
        }
         return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
   
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !CheckInternet.Connection(){
            self.Alert(Message: "Your Device is not connected with internet!")
            
        }else{
            if collectionView.tag == 0{
                NetworkingService.shared.getServicesInformationDetail(id: trending[indexPath.row].id) { (detail, error) in
                    DispatchQueue.main.async {
                        if detail.id != 0{
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
                            vc?.viewModel = detail
                            self.navigationController?.pushViewController(vc!, animated: true)
                        }
                    }
                }
            }
            if collectionView.tag == 1{
                 NetworkingService.shared.getServicesInformationDetail(id: other[indexPath.row].id) { (detail, error) in
                     DispatchQueue.main.async {
                         if detail.id != 0{
                             let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
                             vc?.viewModel = detail
                             self.navigationController?.pushViewController(vc!, animated: true)
                         }
                     }
                 }
                 
            }
            if collectionView.tag == 2{
                if let url = URL(string: post[indexPath.row].link), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
  
}
extension UIImageView {
    public func imageFromURL(urlString: String, PlaceHolderImage:UIImage) {
      
            if let url = NSURL(string: urlString) {
               if let data = NSData(contentsOf: url as URL) {
                let image = UIImage(data: data as Data)
                    self.image = image
               }else{
                   self.image = PlaceHolderImage
               }
           }
           else{
              self.image = PlaceHolderImage
           }
       }
   
}
