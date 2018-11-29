//
//  STVAPIManager.swift
//  STV News
//
//  Created by Pooja Harsha on 27/11/18.
//  Copyright © 2018 Pooja. All rights reserved.
//

import Foundation
import Alamofire

enum STVAPIManager : URLRequestConvertible {
    
    case articles
    case articleImage(id: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .articles, .articleImage:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .articles:
            return "/articles/?count=50&navigationLevelId=1218&orderBy=ranking+ASC%2C+createdAt+ASC&full=1&count=20"
        case .articleImage(let id):
            return "/images/\(id)/rendition/?width=640&height=360"
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try (K.baseURL + path).asURL()
        
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        return urlRequest
    }
}
