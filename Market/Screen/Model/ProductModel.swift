//
//  ProductModel.swift
//  Market
//
//  Created by Ahmet Ali ÇETİN on 27.03.2023.
//

import Foundation

struct ProductModel: Codable {
    let id: Int
    let title: String
    let price: Float
    let description: String
    let category: String
    let image: String
    let rating: RateModel
} 

