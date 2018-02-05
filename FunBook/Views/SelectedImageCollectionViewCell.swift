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
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var coverLabel: UILabel!
    
    var info: PrepareAlbumModel? {
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
    
    func didSetCategory(_ info: PrepareAlbumModel) {
        
//        print(image)
        imageView.image = info.image
        captionLabel.text = info.caption
        dateLabel.text = info.date
        
//        label.text = "\(index)"
    }
}
