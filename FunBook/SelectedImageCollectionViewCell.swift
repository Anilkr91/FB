//
//  SelectedImageCollectionViewCell.swift
//  FunBook
//
//  Created by admin on 10/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

//import Gallery
import UIKit

class SelectedImageCollectionViewCell: UICollectionViewCell {
    
//    var index: Int
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var info: UIImage? {
        didSet {
            if let image = info {
                didSetCategory(image)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.clear
    }
    
    func didSetCategory(_ image: UIImage) {
        
        print(image)
        imageView.image = image
        label.text = "\(index)"
    }
}
