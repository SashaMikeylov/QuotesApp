//
//  QuoteInCategoryViewController.swift
//  QuotesApp
//
//  Created by Денис Кузьминов on 17.10.2023.
//

import UIKit

final class QuoteInCategoryViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    var quotes: [QuoteModel] = []
    let networkService = NetworkServise()
    var category = ""
    
    //MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Quotes"
        quotes = networkService.quotesInCategory(category: category)
        layout()
        tuneTable()
        navBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quotes = networkService.quotesInCategory(category: category)
        tableView.reloadData()
    }
    
    //MARK: - Layout
    
    private func layout() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    //MARK: - Tune table
    
    private func tuneTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIndetifier")
    }

    
    //MARK: - NavBar
    private func navBar() {
        let barButton = UIBarButtonItem(title: "Delete all", style: .plain, target: self, action: #selector(barButtonPressed))
        barButton.tintColor = .systemBrown
        navigationItem.rightBarButtonItem = barButton
    }

   //MARK: - Show alerts
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Delete all categories", message: "Do you want delete all categories ?", preferredStyle: .alert)
        let alertAction1 = UIAlertAction(title: "Cancel", style: .cancel)
        let alertAction2 = UIAlertAction(title: "Delete", style: .default) { _ in
            self.networkService.deleteAllCategories(category: self.category)
            self.quotes = self.networkService.quotesInCategory(category: self.category)
            self.tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true)
    }
 
    //MARK: - Objc func
    
    @objc private func barButtonPressed() {
        showAlert()
    }
}

//MARK: - Extensions

extension QuoteInCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIndetifier", for: indexPath)
        
        let quote = quotes[indexPath.row]
        cell.textLabel?.text = quote.text
        cell.textLabel?.lineBreakMode = .byCharWrapping
        cell.textLabel?.numberOfLines = 10
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(120)
    }
}
