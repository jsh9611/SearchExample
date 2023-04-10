//
//  SearchBooksModel.swift
//  SearchExample
//
//  Created by SeongHoon Jang on 2023/04/08.
//

import Foundation

struct BookInfo: Decodable, Hashable {
    let total: String
    let books: [Books]
}

struct Books: Decodable, Hashable {
    let title: String
    let subtitle: String
    let isbn13: String
    let price: String
    let image: String
    let url: String
}
