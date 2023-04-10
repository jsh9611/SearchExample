//
//  SearchRecentWord.swift
//  SearchExample
//
//  Created by SeongHoon Jang on 2023/04/10.
//

import SwiftUI

struct SearchRecentWord: View {
    @ObservedObject var vm: SearchBooksViewModel
    @Binding var searchText: String
    
    @State private var recentSearches: [String] = []
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 150))]) {
                // 최근 검색어 목록을 표시함
                ForEach(recentSearches, id: \.self) { word in
                    HStack {
                        Button(action: {
                            // 최근 검색어를 눌렀을 때 호출됨
                            searchText = word
                            if !searchText.isEmpty && vm.word != searchText {
                                vm.clearAllData()
                                
                                vm.word = self.searchText
                                
                                vm.loadOnePage()
                                saveSearchWord()
                            }
                            
                        }) {
                            Text(word)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color(UIColor.systemGray3))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {
                            // x 버튼을 눌렀을 때 호출됨
                            deleteSearchTerm(term: word)
                        }) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.black)
                                .font(.title3)
                        }
                    }
                }
            }
            .onAppear {
                // 뷰가 로드될 때 최근 검색어 목록을 로드함
                recentSearches = UserDefaults.standard
                    .array(forKey: UserKeys.recentSearchesKey.rawValue) as? [String] ?? []
            }
            .onReceive(NotificationCenter.default
                .publisher(for: UserDefaults.didChangeNotification)) { _ in
                // UserDefaults가 변경될 때마다 최근 검색어 목록을 다시 로드함
                recentSearches = UserDefaults.standard
                        .array(forKey: UserKeys.recentSearchesKey.rawValue) as? [String] ?? []
            }
        }
    }
    
    // 검색어를 최근 검색어 목록에 추가하고 저장
    private func saveSearchWord() {
        guard !searchText.isEmpty else { return }
        
        // 중복 검색어 제거를 위해 기존 목록에서 해당 검색어를 제거
        var searches = recentSearches.filter { $0 != searchText }
        
        // 새 검색어를 목록 맨 앞에 추가
        searches.insert(searchText, at: 0)
        
        // 최근 검색어 목록을 UserDefaults에 저장
        UserDefaults.standard.set(searches, forKey: UserKeys.recentSearchesKey.rawValue)
    }
    
    // 검색어를 삭제함
    private func deleteSearchTerm(term: String) {
        // 해당 검색어를 최근 검색어 목록에서 제거함
        var searches = recentSearches
        if let index = searches.firstIndex(of: term) {
            searches.remove(at: index)
        }
        
        // 최근 검색어 목록을 UserDefaults에 저장함
        UserDefaults.standard.set(searches, forKey: UserKeys.recentSearchesKey.rawValue)
    }
}
