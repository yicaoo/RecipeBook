//
//  Recipe.swift
//  RecipeBook
//
//  Created by Yi Cao on 11/19/18.
//  Copyright © 2018 Yi Cao. All rights reserved.
//

import Foundation

struct RecipeDataResponse: Codable {
    var results: [Recipe]
}

struct Recipe: Codable {
    var title: String
    var href: String
    var ingredients: String
    var thumbnail: String
}
