//
//  ViewController.swift
//  RecipeBook
//
//  Created by Yi Cao on 11/13/18.
//  Copyright © 2018 Yi Cao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var searchBar: UISearchBar!
    var tableView: UITableView!
    var backgroundView: UIImageView!
    var recipeArray = [Recipe]()
    // for a given table view, store already downloaded images
    var cachedImages: [Int:UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        navigationItem.title = UIConstants.searchPageTitle
        setupSearchBar()
        setupTableView()
        setupBackgroundImage()
        setupConstraints()
    }
    
    // MARK: -Networking requests
    private func getRecipes(for searchQuery: String) {
        NetworkManager.getRecipes(for: searchQuery, completion: { (recipeArray) in
            self.recipeArray = recipeArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) 
    }
    
    private func setImage(cell: RecipeTableViewCell, cellForRowAt indexPath: IndexPath, recipe: Recipe) {
        // if already downloaded, just load from array
        if let image = cachedImages[indexPath.row] {
            cell.recipeImageView.image = image
        } else {
            // otherwise, start new download
            cell.recipeImageView.image = nil
            if recipe.thumbnail.isEmpty {
                cell.recipeImageView.image = UIImage(named: StringConstants.defaultPhoto)
            } else {
                NetworkManager.fetchImage(imageURL: recipe.thumbnail) { (image) in
                    DispatchQueue.main.async {
                        cell.recipeImageView.image = image
                    }
                }
            }
        } 
    }
    
    // MARK: - Layout
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = UIConstants.search
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: UIConstants.tableReuseIdentifier)
        tableView.tableFooterView = UIView() // so there's no empty lines at the bottom
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func setupBackgroundImage() {
        backgroundView = UIImageView()
        backgroundView.image = UIImage(named: StringConstants.backgroundImage)
        backgroundView.contentMode = .scaleAspectFill
        tableView.backgroundView = backgroundView
    }
    
    func setupConstraints() {
        // constraints for searchbar
         NSLayoutConstraint.activate([
         searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
        
        // constraints for tableview
         NSLayoutConstraint.activate([
         tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
         tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
         ])
    }
    
    // MARK: - TableView Functionality
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.tableReuseIdentifier, for: indexPath) as! RecipeTableViewCell
        let currRecipe = recipeArray[indexPath.row]
        // set up contents of the cell
        cell.nameLabel.text = currRecipe.title
        cell.ingredientsLabel.text = StringConstants.ingredientLabel + currRecipe.ingredients
        setImage(cell: cell, cellForRowAt: indexPath, recipe: currRecipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webViewController = WebViewController()
        webViewController.pageURL = recipeArray[indexPath.row].href
    navigationController?.pushViewController(webViewController, animated: true)
    }
    
    // MARK: - Searchbar Functionality
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            getRecipes(for: searchText)
        } else {
            recipeArray.removeAll()
            tableView.reloadData()
        }
    }
    
    // MARK: - Constants
    private struct UIConstants {
        static let tableReuseIdentifier = "RecipeTableViewCell"
        static let search = "Search"
        static let searchPageTitle = "Recipes"
    }
    
    private struct StringConstants {
        static let ingredientLabel = "Ingredients: "
        static let defaultPhoto = "NA"
        static let backgroundImage = "background"
    }
}

