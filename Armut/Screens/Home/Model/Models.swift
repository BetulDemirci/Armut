//
//  Models.swift
//  Armut
//
//  Created by Semafor Teknolojı on 4.09.2020.
//  Copyright © 2020 Semafor Teknolojı. All rights reserved.
//

struct Categories : Codable {
    var trending : [Type1]?
    var other : [Type1]?
    var posts : [Type2]?
    
    enum CodingKeys: String, CodingKey {
           case trending = "trending"
           case other = "other"
           case posts = "posts"
       }

       init(from decoder: Decoder) throws {
           let values = try? decoder.container(keyedBy: CodingKeys.self)
           trending = try? values?.decodeIfPresent([Type1].self, forKey: .trending)
           other = try? values?.decodeIfPresent([Type1].self, forKey: .other)
           posts = try? values?.decodeIfPresent([Type2].self, forKey: .posts)
       }
}

struct Type1 : Codable{
    var id : Int64?
    var service_id : Int64?
    var name : String?
    var long_name : String?
    var image_url : String?
    var pro_count : Int64?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case service_id = "service_id"
        case name = "name"
        case long_name = "long_name"
        case image_url = "image_url"
        case pro_count = "pro_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int64.self, forKey: .id)
        service_id = try? values?.decodeIfPresent(Int64.self, forKey: .service_id)
        name = try? values?.decodeIfPresent(String.self, forKey: .name)
        long_name = try? values?.decodeIfPresent(String.self, forKey: .long_name)
        image_url = try? values?.decodeIfPresent(String.self, forKey: .image_url)
        pro_count = try? values?.decodeIfPresent(Int64.self, forKey: .pro_count)
    }
    
}
struct Type2 : Codable{
    var link : String?
    var title : String?
    var category : String?
    var image_url : String?
    
    enum CodingKeys: String, CodingKey {
        case link = "link"
        case title = "title"
        case category = "category"
        case image_url = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        link = try? values?.decodeIfPresent(String.self, forKey: .link)
        title = try? values?.decodeIfPresent(String.self, forKey: .title)
        category = try? values?.decodeIfPresent(String.self, forKey: .category)
        image_url = try? values?.decodeIfPresent(String.self, forKey: .image_url)
        
    }
    
}

struct Type3 : Codable{
    var id : Int64?
    var service_id : Int64?
    var name : String?
    var long_name : String?
    var image_url : String?
    var pro_count : Int64?
    var average_rating : Double?
    var completed_jobs_on_last_month : Int64?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case service_id = "service_id"
        case name = "name"
        case long_name = "long_name"
        case image_url = "image_url"
        case pro_count = "pro_count"
        case average_rating = "average_rating"
        case completed_jobs_on_last_month = "completed_jobs_on_last_month"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int64.self, forKey: .id)
        service_id = try? values?.decodeIfPresent(Int64.self, forKey: .service_id)
        name = try? values?.decodeIfPresent(String.self, forKey: .name)
        long_name = try? values?.decodeIfPresent(String.self, forKey: .long_name)
        image_url = try? values?.decodeIfPresent(String.self, forKey: .image_url)
        pro_count = try? values?.decodeIfPresent(Int64.self, forKey: .pro_count)
        average_rating = try? values?.decodeIfPresent(Double.self, forKey: .average_rating)
        completed_jobs_on_last_month = try? values?.decodeIfPresent(Int64.self, forKey: .completed_jobs_on_last_month)
    }
    
}

struct categories : Identifiable {
    var id : Int64
    var service : Int64
    var name : String
    var long_name : String
    var image_url : String
    var pro_count : Int64
}

struct posts {
    var link : String
    var title : String
    var category : String
    var image_url : String
}

struct detail : Identifiable {
    var id : Int64
    var service : Int64
    var name : String
    var long_name : String
    var image_url : String
    var pro_count : Int64
    var average_rating : Double
    var completed_jobs_on_last_month : Int64
}



