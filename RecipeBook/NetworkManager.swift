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
    
    static func getRecipes(for searchQuery: String, completion: @escaping ([Recipe]) -> Void) {
        let searchEndpoint = StringConstants.endpoinPrefix + searchQuery.lowercased()
        //print(searchEndpoint)
        Alamofire.request(searchEndpoint, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let recipeResponse = try? jsonDecoder.decode(RecipeDataResponse.self, from: data) {
                    //print(recipeResponse.results)
                    completion(recipeResponse.results)
                } else {
                    print(StringConstants.invalidResponse)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func fetchImage(imageURL: String, completion: @escaping (UIImage) -> Void) {
        Alamofire.request(imageURL).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let recipeImage = UIImage(data: data) {
                    completion(recipeImage)
                } else {
                    print(StringConstants.invalidResponse)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private struct StringConstants {
        static let endpoinPrefix = "http://www.recipepuppy.com/api/?q="
        static let invalidResponse = "Invalid Response Data"
    }
}
