//
//  QuoteRealModel.swift
//  QuotesApp
//
//  Created by Денис Кузьминов on 15.10.2023.
//


import UIKit
import RealmSwift

final class QuoteRealModel: Object {
    
    @objc dynamic var id: String?
    @objc dynamic var text: String?
    @objc dynamic var category: String?
    @objc dynamic var date: String?
    
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    convenience init(quote: QuoteModel) {
        self.init()
        id = quote.id
        text = quote.text
        category = quote.category
        date = quote.date
    }
}
