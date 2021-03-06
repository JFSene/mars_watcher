//
//  ImageDetailsInteractor.swift
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

protocol ImageDetailsBusinessLogic
{
    func showDetails(request: ImageDetails.ShowImage.Request)
}

protocol ImageDetailsDataStore
{
    var imgSrc: String { get set }
    var cameraName: String { get set }
}

class ImageDetailsInteractor: ImageDetailsBusinessLogic, ImageDetailsDataStore
{
    
    var imgSrc: String = ""
    var cameraName: String = ""
    
    var presenter: ImageDetailsPresentationLogic?
    var worker: ImageDetailsWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func showDetails(request: ImageDetails.ShowImage.Request)
    {
        worker = ImageDetailsWorker()
        worker?.doSomeWork()
        
        let response = ImageDetails.ShowImage.Response(imgSrc: imgSrc, cameraName: cameraName)
        presenter?.presentSomething(response: response)
    }
}
