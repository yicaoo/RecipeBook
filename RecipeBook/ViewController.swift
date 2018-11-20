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
        setupSearchBar()
        setupTableView()
        setupConstraints()
        getRecipes()
    }
    
    private func getRecipes() {
        NetworkManager.getRecipes { recipeArray in
            //print(recipeArray)
            self.recipeArray = recipeArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: UIConstants.tableReuseIdentifier)
        //tableView.tableFooterView = UIView() // so there's no empty lines at the bottom
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
    
    private struct UIConstants {
        static let tableReuseIdentifier = "RecipeTableViewCell"
    }
}

