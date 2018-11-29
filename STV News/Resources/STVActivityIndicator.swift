//
//  STVActivityIndicator.swift
//  STV News
//
//  Created by Pooja Harsha on 28/11/18.
//  Copyright © 2018 Pooja. All rights reserved.
//

import UIKit

class STVActivityIndicator: UIView {
    
    var activityIndicatorView = UIActivityIndicatorView()
    
    var needsIndicator: Bool = false {
        didSet{
            addIndicator(needsSpinner: needsIndicator)
        }
    }
    
    init(frame: CGRect, overLayColor: UIColor = UIColor.lightText, needsSpinner: Bool = true) {
        
        super.init(frame:frame)
        backgroundColor = overLayColor
        addIndicator(needsSpinner: needsSpinner)
        
    }
    
    private func addIndicator(needsSpinner: Bool){
        if needsSpinner {
            activityIndicatorView.style = UIActivityIndicatorView.Style.gray
            activityIndicatorView.center = CGPoint(x: bounds.midX, y: bounds.midY)
            self.addSubview(activityIndicatorView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating(){
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating(){
        activityIndicatorView.stopAnimating()
    }
    
}
