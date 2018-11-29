//
//  STVTopStoriesModel.swift
//  STV News
//
//  Created by Pooja Harsha on 27/11/18.
//  Copyright © 2018 Pooja. All rights reserved.
//

import Foundation

struct TopStories: Codable {
    let id: String?
    let title: String?
    var subHeadline : String?
    var contentHTML : String?
    var permalink : String?
    var publishDate : String?
    var imageData: ImageData?
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case subHeadline
        case contentHTML
        case permalink
        case publishDate
        case images
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        subHeadline = try container.decode(String.self, forKey: .subHeadline)
        contentHTML = try container.decode(String.self, forKey: .contentHTML)
        permalink = try container.decode(String.self, forKey: .permalink)
        publishDate = try container.decode(String.self, forKey: .publishDate)
        guard let imagesData = try? container.decode(Array<ImageData>.self, forKey: .images), !imagesData.isEmpty else {
            return
        }
        imageData = imagesData.first
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(subHeadline, forKey: .subHeadline)
        try container.encode(contentHTML, forKey: .contentHTML)
        try container.encode(permalink, forKey: .permalink)
        try container.encode(publishDate, forKey: .publishDate)
        try container.encode([imageData], forKey: .images)        
    }

}

struct ImageData : Codable {
    let id : String?
    let caption : String?
    let description : String?
}
