//
//  STVTableViewCell.swift
//  STV News
//
//  Created by Pooja Harsha on 26/11/18.
//  Copyright © 2018 Pooja. All rights reserved.
//

import UIKit
import AlamofireImage

struct STVTableRowViewData {
    let id:String?
    let title:String?
    let description:String?
    let publishDate:String?
    let thumbnailImageID:String?
    
    init(id:String?, title:String?, description:String?, thumbnailImageID:String?, publishDate:String?) {
        self.id = id
        self.title = title
        self.description = description
        self.publishDate = publishDate
        self.thumbnailImageID = thumbnailImageID
    }
}

class STVTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImgView: UIImageView!
    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblNewsDetail: UILabel!
    var imageURL:String?
    @IBOutlet weak var lblPublishDate: UILabel!
    
    static var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy at HH:mm:ss a"
        return formatter
    }()

    var viewData: STVTableRowViewData? {
        didSet {
            lblNewsTitle.text = viewData?.title
            lblNewsDetail.text = viewData?.description
            lblPublishDate.text = "Published on: \(viewData?.publishDate ?? "Long ago")"
            guard let imageID = viewData?.thumbnailImageID else {
                self.thumbnailImgView.image = #imageLiteral(resourceName: "STVNewsLogo")
                self.imageURL = nil
                return
            }
            STVServiceManager.shared.fetchThumbnailImageURLFromServer(imageID: imageID) { (thumbnailURL) in
                guard let thumbnailURL = thumbnailURL, let url = URL(string: thumbnailURL) else {
                    self.thumbnailImgView.image = #imageLiteral(resourceName: "STVNewsLogo")
                    self.imageURL = nil
                    return
                }
                self.thumbnailImgView.af_setImage(withURL: url)
                self.imageURL = thumbnailURL
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImgView.af_cancelImageRequest()
        thumbnailImgView.image = nil
        self.imageURL = nil

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
