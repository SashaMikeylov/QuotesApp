//
//  AllQuetesViewController.swift
//  QuotesApp
//
//  Created by Денис Кузьминов on 14.10.2023.
//

import UIKit

final class AllQuetesViewController: UIViewController {
    
    private lazy var quotesTableView = UITableView()
    
    let networkService = NetworkServise()
    
    
    //MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Quotes"
        navigationController?.navigationBar.prefersLargeTitles = true
        layuot()
        tuneTableView()
        navBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quotesTableView.reloadData()
    }
    
    //MARK: - Layout
    
    private func layuot() {
        
        view.addSubview(quotesTableView)
        
        NSLayoutConstraint.activate([
            quotesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            quotesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            quotesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            quotesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
    //MARK: - Tune tableView
    
    private func tuneTableView() {
        quotesTableView.translatesAutoresizingMaskIntoConstraints = false
        quotesTableView.backgroundColor = .white
        quotesTableView.dataSource = self
        quotesTableView.delegate = self
        quotesTableView.register(QuotesTableViewCell.self, forCellReuseIdentifier: QuotesTableViewCell.id)
    }
    
    //MARK: - NavBar
    
    private func navBar(){
        let rightNavController = UIBarButtonItem(title: "Delete all", style: .plain, target: self, action: #selector(navBarAction))
        rightNavController.tintColor = .systemBrown
        navigationItem.rightBarButtonItem = rightNavController
    }
    
    //MARK: - Show alerts
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Delete all quotes", message: "Do you want delete all quotes ?", preferredStyle: .alert)
        let alertAction1 = UIAlertAction(title: "Cancel", style: .cancel)
        let alertAction2 = UIAlertAction(title: "Delete", style: .default) { _ in
            self.networkService.deleteAllQuotes()
            self.quotesTableView.reloadData()
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true)
    }
    
//MARK: - Objc func
    
    @objc private func navBarAction() {
        showAlert()
    }
}

//MARK: - Extenshions

extension AllQuetesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        networkService.allQuotes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuotesTableViewCell.id, for: indexPath) as? QuotesTableViewCell else   { return UITableViewCell()}
        let quote = networkService.allQuotes()[indexPath.row]
        cell.configure(quoteModel: quote)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(150)
    }
}
