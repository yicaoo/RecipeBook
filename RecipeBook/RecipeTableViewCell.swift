//
//  RecipeTableViewCell.swift
//  RecipeBook
//
//  Created by Yi Cao on 11/19/18.
//  Copyright © 2018 Yi Cao. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    var nameLabel: UILabel!
    var ingredientsLabel: UILabel!
    var recipeImageView: UIImageView!
    var spinner: UIActivityIndicatorView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // init recipe image view
        recipeImageView = UIImageView()
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.contentMode = .scaleAspectFit
        recipeImageView.clipsToBounds = true
        // init name label
        nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = .boldSystemFont(ofSize: UIConstants.titleFont)
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        // init ingredients list
        ingredientsLabel = UILabel()
        ingredientsLabel.textColor = .gray
        ingredientsLabel.font = .systemFont(ofSize: UIConstants.textFont)
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.lineBreakMode = .byWordWrapping
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spinner)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(recipeImageView)
        setupConstraints()
        spinner.frame = recipeImageView.frame

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: UIConstants.imagePadding),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            ingredientsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ingredientsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: UIConstants.labelVerticalSpacing),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.imagePadding),
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            recipeImageView.widthAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(StringConstants.initError)
    }
    
    private struct UIConstants {
        static let titleFont: CGFloat = 14
        static let textFont: CGFloat = 12
        static let padding: CGFloat = 10
        static let labelVerticalSpacing: CGFloat = 5
        static let imagePadding: CGFloat = 5
        static let ingredientsLabelHeight: CGFloat = 14
    }
    
    private struct StringConstants {
        static let initError = "init(coder:) has not been implemented"
    }
}
