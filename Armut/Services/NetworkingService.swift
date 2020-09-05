//
//  NetworkingService.swift
//  Armut
//
//  Created by Semafor Teknolojı on 4.09.2020.
//  Copyright © 2020 Semafor Teknolojı. All rights reserved.
//
import UIKit

class NetworkingService{
    static let shared = NetworkingService()
    private init(){}
        
    let urlString = "https://my-json-server.typicode.com/engincancan/case";
    var trending = [categories]()
    var other = [categories]()
    var post = [posts]()
    
    
    public func getServicesInformation(completionHandler:@escaping ([categories],[categories],[posts], Error?)->Void) {
        
        DispatchQueue.global(qos: .userInteractive).sync {
            let urlS = urlString + "/home"
            let url = URL(string: urlS)
            var request = URLRequest(url: url!)
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "GET"
            
            let sess = URLSession(configuration: .default)
            sess.dataTask(with: request) { (data, response, error) in
                do{
                   let fetch = try JSONDecoder().decode(Categories.self, from: data!)
                
                    for i in fetch.trending!{
                        self.trending.append(categories(id: i.id ?? 0, service: i.service_id ?? 0, name: i.name ?? "", long_name: i.long_name ?? "", image_url: i.image_url ?? "", pro_count: i.pro_count ?? 0))
                    }
                    for i in fetch.other!{
                        self.other.append(categories(id: i.id ?? 0, service: i.service_id ?? 0, name: i.name ?? "", long_name: i.long_name ?? "", image_url: i.image_url ?? "", pro_count: i.pro_count ?? 0))
                    }
                    for i in fetch.posts!{
                        self.post.append(posts(link: i.link ?? "" , title: i.title ?? "", category: i.category ?? "", image_url: i.image_url ?? ""))
                   }
                    completionHandler(self.trending,self.other, self.post, error)
               }
               catch {
                   print(error.localizedDescription)
                    completionHandler(self.trending,self.other, self.post, error)
               }
           }.resume()
        }
    }
    
    public func getServicesInformationDetail(id:Int64,completionHandler:@escaping (detail, Error?)->Void) {
        var item = detail(id: 0, service: 0, name: "", long_name: "", image_url: "", pro_count: 0, average_rating: 0, completed_jobs_on_last_month: 0)
        
        if id != 0{
            DispatchQueue.global(qos: .userInteractive).sync {
                let urlS = urlString + "/service/\(id)"
                let url = URL(string: urlS)
                var request = URLRequest(url: url!)
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.httpMethod = "GET"
                
                let sess = URLSession(configuration: .default)
                sess.dataTask(with: request) { (data, response, error) in
                    do{
                       let fetch = try JSONDecoder().decode(Type3.self, from: data!)
                        item.id = fetch.id ?? 0
                        item = detail(id: fetch.id ?? 0, service: fetch.service_id ?? 0, name: fetch.name ?? "", long_name: fetch.long_name ?? "", image_url: fetch.image_url ?? "", pro_count: fetch.pro_count ?? 0, average_rating: fetch.average_rating ?? 0, completed_jobs_on_last_month: fetch.completed_jobs_on_last_month ?? 0)
                        completionHandler(item, error)
                   }
                   catch {
                       print(error.localizedDescription)
                        completionHandler(item, error)
                   }
               }.resume()
            }

        }
    }
}
