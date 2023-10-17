//
//  QuoteModel.swift
//  QuotesApp
//
//  Created by Денис Кузьминов on 15.10.2023.
//


import UIKit

struct QuoteModel: Decodable {
    
    let id: String
    let text: String
    let category: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case text = "value"
        case categories
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        text = try container.decode(String.self, forKey: .text)
        
        let categories = try container.decode([String].self, forKey: .categories)
        if let firstCategory = categories.first, !firstCategory.isEmpty {
            category = firstCategory.capitalized
        } else {
            category = "Без категории"
        }
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd MMMM yyyy HH:mm"
        date = dateFormater.string(from: Date())
    }
    
    init(quoteModel: QuoteRealModel) {
        id = quoteModel.id ?? ""
        text = quoteModel.text ?? ""
        category = quoteModel.category ?? ""
        date = quoteModel.date ?? ""
    }
    
    var keyValues: [String: Any] {[
        "id": id,
        "text": text,
        "category": category,
        "date": date
    ]}
}
