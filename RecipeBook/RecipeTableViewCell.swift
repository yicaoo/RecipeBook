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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = .boldSystemFont(ofSize: UIConstants.titleFont)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsLabel = UILabel()
        ingredientsLabel.textColor = .gray
        ingredientsLabel.font = .systemFont(ofSize: UIConstants.textFont)
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.lineBreakMode = .byWordWrapping
        
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        contentView.addSubview(ingredientsLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.padding),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.padding),
            nameLabel.heightAnchor.constraint(equalToConstant: UIConstants.nameLabelHeight)
            ])
        
        NSLayoutConstraint.activate([
            ingredientsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ingredientsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: UIConstants.labelVerticalSpacing),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for recipe: Recipe) {
        nameLabel.text = recipe.title
        ingredientsLabel.text = StringLabelConstants.ingredientLabel + recipe.ingredients
    }
    
    private struct UIConstants {
        static let titleFont: CGFloat = 14
        static let textFont: CGFloat = 12
        static let padding: CGFloat = 10
        static let labelVerticalSpacing: CGFloat = 5
        static let nameLabelHeight: CGFloat = 15
        static let ingredientsLabelHeight: CGFloat = 14
    }
    
    private struct StringLabelConstants {
        static let ingredientLabel = "Ingredients: "
    }
}
