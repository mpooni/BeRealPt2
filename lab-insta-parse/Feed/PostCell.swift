//
//  PostCell.swift
//  lab-insta-parse
//
//  Created by Manasa Pooni on 4/3/23.
//

import UIKit
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {

    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    // Blur view to blur out "hidden" posts
    @IBOutlet private weak var blurView: UIVisualEffectView!

    private var imageDataRequest: DataRequest?

    func configure(with post: Post) {
        // TODO: Pt 1 - Configure Post Cell

        // Username
        if let user = post.user {
            usernameLabel.text = user.username
        }

        // Image
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {

            // Use AlamofireImage helper to fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.postImageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }

        // Caption
        captionLabel.text = post.caption

        // Date
        if let date = post.createdAt {
            dateLabel.text = DateFormatter.postFormatter.string(from: date)
        }

        // TODO: Pt 2 - Show/hide blur view
       
        if let currentUser = User.current,

            
           let lastPostedDate = currentUser.lastPostedDate,

            
           let postCreatedDate = post.createdAt,

           
           let diffHours = Calendar.current.dateComponents([.hour], from: postCreatedDate, to: lastPostedDate).hour {

          
            blurView.isHidden = abs(diffHours) < 24
        } else {

            
            blurView.isHidden = false
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: Pt 1 - Cancel image data request

        // Reset image view image.
        postImageView.image = nil

        // Cancel image request.
        imageDataRequest?.cancel()
    }
}
