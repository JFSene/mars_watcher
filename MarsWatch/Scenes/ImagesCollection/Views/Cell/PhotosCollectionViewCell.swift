//
//  PhotosCollectionViewCell.swift
//  MarsWatch
//
//  Created by BRQ on 26/04/19.
//  Copyright © 2019 BarbaRuiva. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var roverTitle: UILabel!
    @IBOutlet weak var cameraName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 4
    }

    func setUpCell(data: ImagesCollection.Photos.ViewModel.PhotosDisplay) {
        imgView.sd_setImage(with: URL(string: (data.imgSrc?.isEmpty)! ? "" : data.imgSrc ?? ""), placeholderImage: UIImage(named: "placeholder"))
        cameraName.text = data.camera?.fullName
        roverTitle.text = data.rover?.name
    }
    
}
