//
//  NetworkServise.swift
//  QuotesApp
//
//  Created by Денис Кузьминов on 15.10.2023.
//

import Foundation

//MARK: - Network service error

enum NetworkServiceError: Error {
    case notDataError
    case custom(reason: String)
    case responseError
    case urlError
}

//MARK: -  Network service protocol

protocol NetworkServiceProtocol {
    func catchQuote(completion: @escaping (Result<QuoteModel, Error>) -> Void)
    func saveQuote(quote: QuoteModel)
    func deleteQuote(id: String)
    func allQuotes() -> [QuoteModel]
    func deleteAllQuotes()
    func allCategories() -> [String]
    func quotesInCategory(category: String) -> [QuoteModel]
    func deleteAllCategories(category: String)
}

//MARK: - Network service

final class NetworkServise: NetworkServiceProtocol {
    
  private let realmService = RealmService()
    
//MARK: - Request
    
  private func request(completion: @escaping (Result<QuoteModel, NetworkServiceError>) -> Void) {
      
      guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
          completion(.failure(.custom(reason: "wffww")))
          return
      }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.responseError))
                return
            }
            
            guard response is HTTPURLResponse else  {
                completion(.failure(.responseError))
                return
            }
            
            guard let data else {return }
            do {
                let decoder = JSONDecoder()
                let newData = try decoder.decode(QuoteModel.self, from: data)
                completion(.success(newData))
            } catch {
                completion(.failure(.urlError))
            }
            
        }
        task.resume()
    }
    
//MARK: - Catch quote
    
    func catchQuote(completion: @escaping (Result<QuoteModel, Error>) -> Void)  {
        self.request { result in
            switch result {
            case .success(let quote):
                self.saveQuote(quote: quote)
                completion(.success(quote))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
//MARK: - Save Quote
    
    func saveQuote(quote: QuoteModel) {
        realmService.saveQuote(quote: quote)
    }
    
//MARK: - Delete quote
    
    func deleteQuote(id: String) {
        realmService.deleteQuote(id: id)
    }
    
//MARK: - All Quotes
    
    func allQuotes() -> [QuoteModel] {
       return realmService.allQuotes()
    }
    
//MARK: - Delete all quotes
    
    func deleteAllQuotes() {
        realmService.deleteAllQuotes()
    }
    
//MARK: - All categories
    
    func allCategories() -> [String] {
        let categoriesSet = Set(realmService.allCategories())
        let categories = Array(categoriesSet)
        return categories
    }
    
//MARK: - Quotes in categories
    
    func quotesInCategory(category: String) -> [QuoteModel] {
        realmService.quotesInCategory(category: category)
        
    }
    
//MARK: - Delegte all categories
    
    func deleteAllCategories(category: String) {
        realmService.deleteAllCategories(category: category)
    }
}
