////
////  SearchListView.swift
////  SearchExample
////
////  Created by SeongHoon Jang on 2023/04/06.
////
//
//import SwiftUI
//import Combine
//
////struct SearchListView: View {
////    var body: some View {
////        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
////    }
////}
//
////struct EndlessList: View {
////  @StateObject var dataSource = ContentDataSource()
////
////  var body: some View {
////    ScrollView {
////      LazyVStack {
////          ForEach(dataSource.items, id: \.self) { item in
////          Text(item.label)
////            .onAppear {
////              dataSource.loadMoreContentIfNeeded(currentItem: item)
////            }
////            .padding(.all, 30)
////        }
////
////        if dataSource.isLoadingPage {
////          ProgressView()
////        }
////      }
////    }
////  }
////}
//
////class ContentDataSource: ObservableObject {
////  @Published var items = [Books]()
////  @Published var isLoadingPage = false
////  private var currentPage = 1
////  private var canLoadMorePages = true
////
////  init() {
////    loadMoreContent()
////  }
////
////  func loadMoreContentIfNeeded(currentItem item: Books?) {
////    guard let item = item else {
////      loadMoreContent()
////      return
////    }
////
////    let thresholdIndex = items.index(items.endIndex, offsetBy: -5)
////      if items.firstIndex(where: { $0.isbn13 == item.isbn13 }) == thresholdIndex {
////      loadMoreContent()
////    }
////  }
////
////    private func loadMoreContent() {
////      guard !isLoadingPage && canLoadMorePages else {
////        return
////      }
////
////      isLoadingPage = true
////
////      let url = URL(string: "https://s3.eu-west-2.amazonaws.com/com.donnywals.misc/feed-\(currentPage).json")!
////      URLSession.shared.dataTaskPublisher(for: url)
////        .map(\.data)
////        .decode(type: ListResponse.self, decoder: JSONDecoder())
////        .receive(on: DispatchQueue.main)
////        .handleEvents(receiveOutput: { response in
////          self.canLoadMorePages = response.hasMorePages
////          self.isLoadingPage = false
////          self.currentPage += 1
////        })
//////        .map({ response in
//////          return self.items + response.items
//////        })
//////        .catch({ _ in Just(self.items) })
////        .assign(to: &$items)
////    }
////}
//
//
//
//
//final class UsersViewModel: ObservableObject {
//    
//    @Published var bookInfo: BookInfo = BookInfo(total: "", books: [])
////    @Published var users: [User] = []
//    @Published var hasError = false
//    @Published var error: UserError?
//    @Published private(set) var isRefreshing = false
//    
//    func fetchUsers() {
//        
//        let usersUrlString = "https://jsonplaceholder.typicode.com/users"
//        
//        // 1)
//        if let url = URL(string: usersUrlString) {
//            
//            URLSession
//                .shared
//            // 2)
//                .dataTask(with: url) { [weak self] data, response, error in
//                    
//                    DispatchQueue.main.async {
//                        
//                        if let error = error {
//                            // TODO: Handle UserError error
//                            self?.hasError = true
//                            self?.error = .custom(error: error)
//                            
//                        } else {
//                            
//                            let decoder = JSONDecoder()
//                            decoder.keyDecodingStrategy = .convertFromSnakeCase
//                            
//                            if let data = data,
//                               let bookInfo = try? decoder.decode(BookInfo.self, from: data) {
//                                // TODO: Handle setting the data
//                                
//                                // 4)
//                                self?.bookInfo = bookInfo
//                                
//                            } else {
//                                // TODO: Handle Decode error
//                                
//                            }
//                        }
//                    }
//                }.resume()
//        }
//    }
//    enum UserError: LocalizedError {
//        case custom(error: Error)
//        case failedToDecode
//        
//        var errorDescription: String? {
//            switch self {
//            case .failedToDecode:
//                return "Failed to decode response"
//            case .custom(let error):
//                return error.localizedDescription
//            }
//        }
//    }
//}
