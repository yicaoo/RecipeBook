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
    var recipeArray = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        navigationItem.title = UIConstants.searchPageTitle
        setupSearchBar()
        setupTableView()
        setupConstraints()
        //getRecipes()
    }
    
    private func getRecipes(for searchQuery: String) {
        NetworkManager.getRecipes(for: searchQuery, completion: { (recipeArray) in
            self.recipeArray = recipeArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) 
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
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: UIConstants.tableReuseIdentifier)
        tableView.tableFooterView = UIView() // so there's no empty lines at the bottom
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
         NSLayoutConstraint.activate([
         searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
        
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
        cell.configure(for: recipeArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
}

