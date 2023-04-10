//
//  ContentView.swift
//  SearchExample
//
//  Created by SeongHoon Jang on 2023/04/06.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = SearchBooksViewModel()
    @State private var searchText = ""
    
    private var isTextEmpty: Bool {
        searchText.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(vm: vm, text: $searchText)
                ScrollView {
                    if searchText.isEmpty {
                        SearchRecentWord(vm: vm, searchText: $searchText)
                    }
                    
                    SearchBooksView(vm: vm, isTextEmpty: isTextEmpty)
                }
                
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

//"title": "Learn PostgreSQL"
//"subtitle":"Build and manage high-performance database solutions using PostgreSQL 12 and 13"
//"isbn13": "9781838985288"
//"price": "$44.99"
//"image": "https://itbook.store/img/books/9781838985288.png"
//"url": "https://itbook.store/books/9781838985288"
