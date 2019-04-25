//
//  Photos.swift
//  MarsWatch
//
//  Created by BRQ on 25/04/19.
//  Copyright © 2019 BarbaRuiva. All rights reserved.
//

import Foundation

struct PhotosModel: Codable {
    let photos: [Photo]?
}

struct Photo: Codable {
    let id, sol: Int?
    let camera: PhotoCamera?
    let imgSrc: String?
    let earthDate: String?
    let rover: Rover?
    
    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

struct PhotoCamera: Codable {
    let id: Int?
    let name: String?
    let roverID: Int?
    let fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

struct Rover: Codable {
    let id: Int?
    let name, landingDate, launchDate, status: String?
    let maxSol: Int?
    let maxDate: String?
    let totalPhotos: Int?
    let cameras: [CameraElement]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras
    }
}

struct CameraElement: Codable {
    let name, fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}
