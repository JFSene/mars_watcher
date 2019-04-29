//
//  ImageDetailsPresenter.swift
//  MarsWatch
//
//  Created by BRQ on 26/04/19.
//  Copyright (c) 2019 BarbaRuiva. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ImageDetailsPresentationLogic
{
  func presentSomething(response: ImageDetails.ShowImage.Response)
}

class ImageDetailsPresenter: ImageDetailsPresentationLogic
{
  weak var viewController: ImageDetailsDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: ImageDetails.ShowImage.Response)
  {
    let testA = response.cameraName
    let testB = response.imgSrc
    
    let viewModel = ImageDetails.ShowImage.ViewModel(imgSrc: testB, cameraName: testA)
    viewController?.displaySomething(viewModel: viewModel)
  }
}