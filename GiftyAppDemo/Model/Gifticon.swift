//
//  Card.swift
//  GiftyAppDemo
//
//  Created by 성대규 on 1/7/24.
//
import SwiftUI
import Foundation


struct Gifticon: Codable, Identifiable, Hashable {
  var id: UUID = .init()
  var productName: String
  var imgName: String = "photo"
  var expDate: Date
  var brandName: String
  var barcodeNum: String
}
