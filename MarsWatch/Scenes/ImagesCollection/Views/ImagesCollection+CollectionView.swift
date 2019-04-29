//
//  ImagesCollection+CollectionView.swift
//  MarsWatch
//
//  Created by BRQ on 26/04/19.
//  Copyright © 2019 BarbaRuiva. All rights reserved.
//

import UIKit
import SDWebImage

extension ImagesCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath) as! PhotosCollectionViewCell
        
        let item = photosCollection[indexPath.row]
        cell.setUpCell(data: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let item = photosCollection[indexPath.row]
        routToDetails(imgName: item.camera!, image: item.imgSrc!)
    }
    
    
}
