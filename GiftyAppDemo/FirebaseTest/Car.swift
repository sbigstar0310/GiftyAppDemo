//
//  Car.swift
//  GiftyAppDemo
//
//  Created by 성대규 on 1/26/24.
//

import Foundation

struct Car : Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var description: String
    var isHybrid: Bool
}
