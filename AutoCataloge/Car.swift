//
//  Car.swift
//  AutoCataloge
//
//  Created by Dmitry on 02/04/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

// Model
class Car: Codable {
    enum Property: String {
        case year
        case model
        case manufactures
        case `class`
        case bodyType
        
        static let allValues: [Property] = [.year, .model, .manufactures, .class, .bodyType]
    }
    private var data: [String] = []
    //
    subscript (property: Property) -> String {
        get {
            if let index =  Property.allValues.firstIndex(of: property), index < data.count {
                return data[index]
            }
            return ""
        }
        set {
            if let index =  Property.allValues.firstIndex(of: property), index < data.count {
                while data.count <= index {
                    data.append("")
                }
                data[index] = newValue
            }
        }
    }
    
    // init по умолчанию
    init() {
        data = [String](repeating: "", count: Property.allValues.count)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        //        let decodableData = try container.decode([String: String].self)
        //        for (key, value) in decodableData {
        //            data[Property(rawValue: key)!] = value
        //        }
        data = try container.decode([String].self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        //        var result : [String : String] = [:]
        //        for (key, value) in data {
        //            result[key.rawValue] = value
        //        }
        try container.encode(data)
    }
}
