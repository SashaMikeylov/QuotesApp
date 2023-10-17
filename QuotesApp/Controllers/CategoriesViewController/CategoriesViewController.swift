//
//  CategoriesViewController.swift
//  QuotesApp
//
//  Created by Денис Кузьминов on 14.10.2023.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    var categories: [String] = []
    private let networkService = NetworkServise()
    
    //MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        categories = networkService.allCategories()
        tuneTable()
        layout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categories = networkService.allCategories()
        tableView.reloadData()
        
    }
    
    //MARK: - Layout
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    //MARK: - Tune table
    
    private func tuneTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIndetifier")
        tableView.backgroundColor = .white
    }
}

    //MARK: - Extenshions

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIndetifier", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        cell.textLabel?.textColor = .systemBrown
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(70)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = QuoteInCategoryViewController()
        viewController.category = categories[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}

