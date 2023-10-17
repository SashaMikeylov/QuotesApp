//
//  RealmService.swift
//  QuotesApp
//
//  Created by Денис Кузьминов on 15.10.2023.
//

import Foundation
import RealmSwift


//MARK: - RealmServiceProtocol

protocol RealmServiceProtocol {
    func saveQuote(quote: QuoteModel)
    func deleteQuote(id: String)
    func allQuotes() -> [QuoteModel]
    func deleteAllQuotes()
    func allCategories() -> [String]
    func quotesInCategory(category: String) -> [QuoteModel]
    func deleteAllCategories(category: String)
}


//MARK: - RealmService

final class RealmService: RealmServiceProtocol {
    
    //MARK: - Save quote
    
    func saveQuote(quote: QuoteModel) {
        
        do {
            let realm = try Realm()
            let handler: () -> Void = {
                if let selectedQuete = realm.object(ofType: QuoteRealModel.self, forPrimaryKey: quote.id) {
                    realm.delete(selectedQuete)
                    realm.create(QuoteRealModel.self, value: quote.keyValues)
                } else {
                    realm.create(QuoteRealModel.self, value: quote.keyValues)
                }
            }
            
            if realm.isInWriteTransaction {
                handler()
            } else {
                try realm.write {
                    handler()
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Delete quote
    
    func deleteQuote(id: String) {
        
        do {
            let realm = try Realm()
            
            var objects: [QuoteRealModel] = []
            for object in realm.objects(QuoteRealModel.self) {
                if object.id == id {
                    objects.append(object)
                }
            }
            
            let handler: () -> Void = {
                realm.delete(objects)
            }
            
            if realm.isInWriteTransaction {
                handler()
            } else {
                try realm.write {
                    handler()
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - All quotes
    
    func allQuotes() -> [QuoteModel] {
        do {
            let realm = try Realm()
            
            let allObjects = realm.objects(QuoteRealModel.self)
            let quotes = allObjects.map {
                QuoteModel(quoteModel: $0)
            }
            return Array(quotes)
        } catch {
            print(error.localizedDescription).self
            return []
        }
    }
    
    //MARK: - Delete all quotes
    
    func deleteAllQuotes() {
        
        do {
            let realm = try Realm()
            
            if realm.isInWriteTransaction {
                realm.deleteAll()
            } else {
                try realm.write {
                    realm.deleteAll()
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    //MARK: - All categories
    
    func allCategories() -> [String] {
        
        do {
            
            let realm = try Realm()
            let categories = realm.objects(QuoteRealModel.self).compactMap {$0.category}
            return Array(categories)
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
//MARK: - Quotes in category
    
    func quotesInCategory(category: String) -> [QuoteModel] {
        do {
            let realm = try Realm()
            var quotes: [QuoteModel] = []
            let categories = realm.objects(QuoteRealModel.self)
            for object in categories {
                if category == object.category {
                    quotes.append(QuoteModel(quoteModel: object))
                }
            }
            return quotes
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
//MARK: - Delete all categories
    
    func deleteAllCategories(category: String) {
        
        do {
            let realm = try Realm()
            var categories: [QuoteRealModel] = []
            let objects = realm.objects(QuoteRealModel.self)
            for objectCategory in objects {
                if category == objectCategory.category {
                    categories.append(objectCategory)
                }
            }
            
            let handler: () -> Void = {
                realm.delete(categories)
            }
            
            if realm.isInWriteTransaction {
                handler()
            } else {
              try realm.write {
                    handler()
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
