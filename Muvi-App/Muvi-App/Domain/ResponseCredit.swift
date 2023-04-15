//
//  ResponseCredit.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 15/04/23.
//

import Foundation
import ObjectMapper

class ResponseCredit: Mappable {
    var cast: [RemoteCast]?
    required init?(map: ObjectMapper.Map) { }
    
    func mapping(map: ObjectMapper.Map) {
        cast <- map["cast"]
    }
}

class RemoteCast: Mappable {
    var id: Int?
    var departement: String?
    var nameCast: String?
    var imagePath: String?
    
    required init?(map: ObjectMapper.Map) { }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        departement <- map["known_for_department"]
        nameCast <- map["name"]
        imagePath <- map["profile_path"]
    }
}

struct CastModel {
    let id: Int
    let departement: String
    let nameCast: String
    let imageUrlString: String
}
