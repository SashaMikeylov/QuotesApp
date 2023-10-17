//
//  QuotesTableViewCell.swift
//  QuotesApp
//
//  Created by Денис Кузьминов on 17.10.2023.
//

import UIKit

final class QuotesTableViewCell: UITableViewCell {
    
    static let id = "QuotesTableViewCell"

    private lazy var quoteCategory: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBrown
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 10
        
        return label
    }()
    
    private lazy var quoteDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        
        return label
    }()
    
//MARK: - Life
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Layout
    
    private func layout() {
        
        addSubview(quoteCategory)
        addSubview(quoteLabel)
        addSubview(quoteDate)
        
        NSLayoutConstraint.activate([
            
            quoteCategory.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            quoteCategory.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            quoteLabel.topAnchor.constraint(equalTo: quoteCategory.topAnchor, constant: 10),
            quoteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            quoteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            quoteLabel.bottomAnchor.constraint(equalTo: quoteDate.topAnchor, constant: 10),
            
            quoteDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            quoteDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
        ])
        
    }
    
//MARK: - Func
    
    func configure(quoteModel: QuoteModel) {
        quoteCategory.text = quoteModel.category
        quoteLabel.text = quoteModel.text
        quoteDate.text = quoteModel.date
    }
    
}

