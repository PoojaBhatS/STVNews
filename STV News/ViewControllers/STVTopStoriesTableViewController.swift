//
//  STVTopStoriesTableViewController.swift
//  STV News
//
//  Created by Pooja Harsha on 26/11/18.
//  Copyright © 2018 Pooja. All rights reserved.
//

import UIKit
import Alamofire

class STVTopStoriesTableViewController: UITableViewController {

    private var topStories = [TopStories]()
    private var topStoriesDataSource = [STVTableRowViewData]()
    private var storyContent : String = ""
    private var storyImage : String = ""
    
    // Activity indicator view
    private var activityIndicator: STVActivityIndicator?
    
    private let tblRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadTopStories()
        addRefreshControl()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if topStoriesDataSource.count == 0 {
            tableView.separatorStyle = .none
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
        }
        return topStoriesDataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier:"STVTableViewCell", for: indexPath)
            as! STVTableViewCell
        let data = topStoriesDataSource[indexPath.row]
        cell.viewData = data
        cell.accessibilityIdentifier = "topStoriesTable.cell.\(indexPath.row)"
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! STVTableViewCell
        let viewData = topStories[indexPath.row]
        guard let newsStory = topStories.first(where: { $0.id == viewData.id }) else {
            return
        }
        storyImage = cell.imageURL ?? ""
        storyContent = newsStory.contentHTML ?? ""
        performSegue(withIdentifier: "StoryDetailSegue", sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let destinationVC = segue.destination as? STVStoryDetailViewController
        // Pass the selected object to the new view controller.
        destinationVC?.articleContent = storyContent
        destinationVC?.articleImageURL = storyImage
    }
}

extension STVTopStoriesTableViewController {
    
    private func loadTopStories() {
        // Initiate activity indicator view
        activityIndicator = STVActivityIndicator.init(frame: self.view.frame)
        self.view.addSubview(activityIndicator!)
        activityIndicator?.startAnimating()
        getTopStories()
    }
    private func addRefreshControl() {
        tblRefreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        tableView.refreshControl = tblRefreshControl
    }

    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        getTopStories()
        self.tblRefreshControl.endRefreshing()
    }
    
    private func getTopStories() {
        STVServiceManager.shared.fetchTopStoriesFromAPI { (topStoryArray) in
            guard let stories = topStoryArray, !stories.isEmpty else {
                //Set Tableview placeholder view
                return;
            }
            self.topStories = stories
            self.topStoriesDataSource = self.topStories.map({ (newsStory) -> STVTableRowViewData in
                return STVTableRowViewData(id:newsStory.id, title: newsStory.title, description: newsStory.subHeadline, thumbnailImageID: newsStory.imageData?.id, publishDate:newsStory.publishDate)
            })
            self.tableView.reloadData()
            self.activityIndicator?.stopAnimating()
            self.activityIndicator?.removeFromSuperview()
        }
    }

}
