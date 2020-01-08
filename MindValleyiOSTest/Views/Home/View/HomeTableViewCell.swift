//
//  HomeTableViewCell.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import UIKit
import MindValleyImageProcessor

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var categoriesLabel: UILabel!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    func configureView(_ uiModel: UIModel) {
        loadingActivityIndicator.startAnimating()
        usernameLabel.text = uiModel.username
        likesLabel.text = "\(uiModel.likes)"
        ImageCacher.shared.image(with: uiModel.imageUrl, progress: nil) { [weak self] (image) in
            guard let self = self else { return }
            self.loadingActivityIndicator.stopAnimating()
            self.userImageView?.image = image
        }
    }
    
    override func prepareForReuse() {
        userImageView.image = nil
    }
}

extension HomeTableViewCell {
    struct UIModel {
        var likes: Int
        var username: String
        var categories: [Category]
        var imageUrl: String?
    }
}
