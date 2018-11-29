//
//  STVStoryDetailViewController.swift
//  STV News
//
//  Created by Pooja Harsha on 26/11/18.
//  Copyright © 2018 Pooja. All rights reserved.
//

import UIKit
import WebKit

class STVStoryDetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var storyDetail: WKWebView!
    var articleContent : String = ""
    var articleImageURL: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
    
    func loadWebView() {
        
        //Make height and width for the image according to the view
        let width = storyDetail.frame.width + 590
        let height = storyDetail.frame.height
        var aribitraryHTMLString : String = ""
        if let imageURL = articleImageURL, let url = URL(string: imageURL) {
            aribitraryHTMLString =  "<html><head></head><body><img border='0' src='\(url)' width='\(width)' height='\(height)'>\(articleContent)</body></html>"
        } else {
            aribitraryHTMLString =  "<html><head></head><body><img border='0' src='STVNewsLogo.jpg' width='\(width)' height='\(height)'>\(articleContent)</body></html>"
        }
        storyDetail.loadHTMLString(aribitraryHTMLString, baseURL: Bundle.main.bundleURL)
    }

}
