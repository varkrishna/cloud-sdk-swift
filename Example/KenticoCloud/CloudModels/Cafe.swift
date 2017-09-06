//
//  CafeCloudModel.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 15/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper

public class Cafe: Mappable {
    public var city: String?
    public var street: String?
    public var country: String?
    public var state: String?
    public var zip: String?
    public var phone: String?
    public var email: String?
    public var imageUrl: String?
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        city <- map["elements.city.value"]
        street <- map["elements.street.value"]
        country <- map["elements.country.value"]
        state <- map["elements.state.value"]
        zip <- map["elements.zip_code.value"]
        phone <- map["elements.phone.value"]
        email <- map["elements.email.value"]
        imageUrl <- map["elements.photo.value.0.url"]
    }
}