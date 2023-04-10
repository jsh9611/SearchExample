//
//  SearchBooksViewModel.swift
//  SearchExample
//
//  Created by SeongHoon Jang on 2023/04/08.
//

import SwiftUI

final class SearchBooksViewModel: ObservableObject {
    @Published var books: [Books] = []
    @Published var isLoadingFinished = false
    
    var word = ""
    var currentPage = 1
    let api = SearchBooksAPI()
    
    /// 한페이지씩 책 리스트를 부르는 API 요청
    ///
    /// 1페이지부터 다음 페이지가 없을 때 까지 요청한다
    ///
    /// [GET] PATH: /search/{ word }/{ currentPage }
    func loadOnePage() {
        if self.isLoadingFinished {
            print("Done")
            return
        }
        
        api.fetchBooks(word: word, page: currentPage) { result in
            switch result {
            case .success(let books):
                if books.count > 0 {
                    print("request: \(self.currentPage) is successful")
                    self.books.append(contentsOf: books)
                    self.currentPage += 1
                } else {
                    self.isLoadingFinished = true
                    print("There is no data!")
                }
            case .failure(let error):
                print("Error loading more todos: \(error.localizedDescription)")
            }
        }
    }
    
    /// 검색어, 페이지 번호, 책 데이터, 로딩 완료 여부를 초기화
    func clearAllData() {
        self.currentPage = 1
        self.isLoadingFinished = false
        self.word.removeAll()
        self.books.removeAll()
    }
}
