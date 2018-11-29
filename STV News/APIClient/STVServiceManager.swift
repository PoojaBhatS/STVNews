//
//  STVServiceManager.swift
//  STV News
//
//  Created by Pooja Harsha on 27/11/18.
//  Copyright © 2018 Pooja. All rights reserved.
//

import Foundation
import Alamofire

class STVServiceManager {
    static let shared = STVServiceManager(baseURL: URL(string:K.baseURL))
    let baseURL: URL?
    // Initialization
    private init(baseURL: URL?) {
        self.baseURL = baseURL
    }

    func fetchTopStoriesFromAPI(completionHandler: @escaping ([TopStories]?) -> Void) {
        requestGETURL(STVAPIManager.articles, success: { (responseData) in
            var users = [TopStories]()
            do{
                guard let responseData = responseData else {
                    completionHandler(nil)
                    return
                }
                users  = try JSONDecoder().decode(Array<TopStories>.self, from: responseData)
                print(users.count)
                completionHandler(users)
            }catch{
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }) { (error) in
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    func fetchThumbnailImageURLFromServer(imageID:String, completionHandler: @escaping (String?) -> Void) {
        requestGETURL(STVAPIManager.articleImage(id: imageID), success: { (responseData) in
            do{
                guard
                    let data = responseData,
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: String],
                    let url = json["url"]
                    else {
                        completionHandler(nil)
                        return
                }
                completionHandler(url)
        }catch{
            print(error.localizedDescription)
            completionHandler(nil)
            }

        }) { (error) in
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    private func requestGETURL(_ urlRequest: STVAPIManager, success:@escaping (Data?) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(urlRequest)
            .responseJSON { (responseObject) ->Void in
                print(responseObject)
                if responseObject.result.isSuccess {
                    guard let jsonValue = responseObject.result.value else {
                        success("Could not get JSON value".data(using: .utf8))
                        return
                    }
                    guard let data = try? JSONSerialization.data(withJSONObject: jsonValue) else {
                        success("Could not parse data".data(using: .utf8))
                        return
                    }
                    success(data)
                }
                if responseObject.result.isFailure {
                    let error : Error = responseObject.result.error!
                    failure(error)
                }
        }
    }
}
