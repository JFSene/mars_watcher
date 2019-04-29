//
//  ImagesCollectionPresenter.swift
//  MarsWatch
//
//  Created by BRQ on 25/04/19.
//  Copyright (c) 2019 BarbaRuiva. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ImagesCollectionPresentationLogic
{
    func successGetPhotosCollection(response: ImagesCollection.Photos.Response.Success)
    func failureGetPhotosCollection(response: ImagesCollection.Photos.Response.Failure)
    func presenterShowDetails(response: ImagesCollection.ShowDetails.Response)
}

class ImagesCollectionPresenter: ImagesCollectionPresentationLogic
{
    
    
  weak var viewController: ImagesCollectionDisplayLogic?
  
  // MARK: Do something
  
  func successGetPhotosCollection(response: ImagesCollection.Photos.Response.Success) {
    let photos = response.photos.compactMap {
        ImagesCollection.Photos.ViewModel.PhotosDisplay (
            camera: $0.camera,
            imgSrc: $0.imgSrc,
            rover: $0.rover
        )
    }
    let vm = ImagesCollection.Photos.ViewModel.Success(items: photos)
    viewController?.successGetPhotosCollection(response: vm)
  }
    
   func failureGetPhotosCollection(response: ImagesCollection.Photos.Response.Failure) {
    let vm = ImagesCollection.Photos.ViewModel.Failure(message: response.error.localizedDescription)
    self.viewController?.failureGetPhotosCollection(response: vm)
    }
    
    func presenterShowDetails(response: ImagesCollection.ShowDetails.Response) {
        let viewModel = ImagesCollection.ShowDetails.ViewModel()
        viewController?.showDetails(response: viewModel)
    }
}
