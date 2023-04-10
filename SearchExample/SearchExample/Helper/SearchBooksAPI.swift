//
//  SearchBooksAPI.swift
//  SearchExample
//
//  Created by SeongHoon Jang on 2023/04/08.
//

import SwiftUI

struct SearchBooksAPI {
    func fetchBooks(word: String, page: Int, completion: @escaping (Result<[Books], Error>) -> Void) {
        // API 호출 및 데이터 처리 로직 구현
        let url = URL(string: "https://api.itbook.store/1.0/search/\(word)/\(page)")!
        URLSession
            .shared
            .dataTask(with: url) { data, response, error in
                print("request: \(page)")
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    guard let data = data else {
                        completion(.failure(APIError.noData))
                        return
                    }
                    do {
                        let bookInfo = try JSONDecoder().decode(BookInfo.self, from: data)
                        completion(.success(bookInfo.books))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
    }
}

enum APIError: Error {
    case noData
}
