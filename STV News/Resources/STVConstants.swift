//
//  STVConstants.swift
//  STV News
//
//  Created by Pooja Harsha on 27/11/18.
//  Copyright © 2018 Pooja. All rights reserved.
//

struct K {
    static let baseURL = "http://api.stv.tv"
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "application/json"
    case text = "text/html"
}
