//
//  NetworkManager.swift
//  RecipeBook
//
//  Created by Yi Cao on 11/19/18.
//  Copyright © 2018 Yi Cao. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    /// Endpoint URL string
    private static let endpoint = "http://www.recipepuppy.com/api/?i=onions,garlic&q=omelet"
    static func getRecipes(completion: @escaping ([Recipe]) -> Void) {
        Alamofire.request(endpoint, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    //print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let recipeResponse = try? jsonDecoder.decode(RecipeDataResponse.self, from: data) {
                    //print(recipeResponse.results)
                    completion(recipeResponse.results)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
