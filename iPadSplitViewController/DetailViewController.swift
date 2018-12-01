//
//  DetailViewController.swift
//  iPadSplitViewController
//
//  Created by Ruslan Akberov on 01/12/2018.
//  Copyright © 2018 Ruslan Akberov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var cake: Cake? {
        didSet {
           refreshUI()
        }
    }
    
    func refreshUI() {
        loadViewIfNeeded()
        nameLabel.text = cake?.name
        descriptionLabel.text = cake?.description
        imageView.image = cake?.image
    }
    
}

extension DetailViewController: CakeSelectionDelegate {
    
    func cakeSelected(_ cake: Cake) {
        self.cake = cake
    }
    
}
