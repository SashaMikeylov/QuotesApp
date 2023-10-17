//
//  QuotesGeneratorViewController.swift
//  QuotesApp
//
//  Created by Денис Кузьминов on 14.10.2023.
//

import UIKit

final class QuotesGeneratorViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Generate Quotes"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "mainIcon")
        
        
        return image
    }()
    
    private let labelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray5
        view.layer.borderColor = UIColor.systemBrown.cgColor
        view.layer.borderWidth = 2
        
        
        return view
    }()
    
    private lazy var quotesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = ""
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 10
        
        return label
    }()
    
    private lazy var loadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBrown
        button.setTitle("Load quotes", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }()
    
//MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layot()
    }

//MARK: - Layout
    private func layot() {
        
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(labelView)
        labelView.addSubview(quotesLabel)
        view.addSubview(loadButton)
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            
            labelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            labelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelView.heightAnchor.constraint(equalToConstant: 200),
            
            quotesLabel.centerXAnchor.constraint(equalTo: labelView.centerXAnchor),
            quotesLabel.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),
            quotesLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 10),
            quotesLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -10),
            
            loadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadButton.heightAnchor.constraint(equalToConstant: 50),
            loadButton.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
//MARK: - Objc func
    
    @objc private func buttonAction() {
        NetworkServise().catchQuote {[weak self] result in
            switch result {
            case .success(let quote):
                DispatchQueue.main.async {
                    self?.quotesLabel.text = quote.text
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

