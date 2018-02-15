//
//  PageItemController.swift
//  FunBook
//
//  Created by admin on 14/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
class PageItemController: UIViewController {
    
    // MARK: - Variables
    var pageIndex: Int = 0
    var heading: String = ""
    var desc: String = ""
    var imageName: String = "" {
        
        didSet {
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    @IBOutlet var contentImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentImageView!.image = UIImage(named: imageName)
        titleLabel!.text = heading
    }
}
