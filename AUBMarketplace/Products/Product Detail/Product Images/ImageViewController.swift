//
//  ImageViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/11/21.
//

import UIKit

class ImageViewController: UIViewController {
    
    let urlString: String
    let imageView = UIImageView()
    
    init(from url: String) {
        self.urlString = url
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFill
        
        view.addSubview(imageView)
        imageView.fillSuperview()
        
        if let url = NSURL(string: urlString) {
            ProductImageCache.publicCache.load(url: url, product: nil) { (product, image) in
                if let image = image {
                    self.imageView.image = image
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
