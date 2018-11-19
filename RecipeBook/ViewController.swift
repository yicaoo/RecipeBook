//
//  ViewController.swift
//  RecipeBook
//
//  Created by Yi Cao on 11/13/18.
//  Copyright © 2018 Yi Cao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getRecipes()
        
    }
    
    func getRecipes() {
        NetworkManager.getRecipes { recipeArray in
            print(recipeArray)
            //self.recipes = recipeArray
            // DispatchQueue.main.async {
            
            
        }
    }

}

