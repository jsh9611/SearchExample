////
////  BookmarkButtonView.swift
////  SearchExample
////
////  Created by SeongHoon Jang on 2023/04/09.
////
//
//import SwiftUI
//
//struct BookmarkButton: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @FetchRequest(
//        entity: Bookmark.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \Bookmark.isbn13, ascending: false)])
//    private var bookmarks: FetchedResults<Bookmark>
//    
//    let book: Books
//    
//    private var isBookmarked: Bool {
//        bookmarks.contains { $0.isbn13 == book.isbn13 }
//    }
//    
//    var body: some View {
//        Button(action: toggleBookmark) {
//            VStack {
//                Image(systemName: isBookmarked ? "heart.fill" : "heart")
//                    .resizable()
//                    
//                    .foregroundColor(isBookmarked ? .red : .gray)
//                
//            }
//            .frame(width: 25, height: 25)
//            .contentShape(Rectangle())
//        }
//    }
//}
//
////MARK: - CoreData에서 사용하는 함수
//private extension BookmarkButton {
//
//    func saveItems() {
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    
//    func saveBookmark(book: Books) {
//        let bookmark = Bookmark(context: viewContext)
//        bookmark.title = book.title
//        bookmark.subtitle = book.subtitle
//        bookmark.isbn13 = book.isbn13
//        bookmark.price = book.price
//        bookmark.image = book.image
//        bookmark.url = book.url
//    }
//    
//    func deleteBookmark(offsets: IndexSet) {
//        withAnimation {
//            
//            guard let index = offsets.first else { return }
//            let bookmark = bookmarks[index]
//            viewContext.delete(bookmark)
//            
//            saveItems()
//        }
//    }
//    
//    func toggleBookmark() {
//        if let bookmark = bookmarks.first(where: { $0.isbn13 == book.isbn13 }) {
//            withAnimation {
//                viewContext.delete(bookmark)
//                saveItems()
//            }
//        } else {
//            saveBookmark(book: book)
//        }
//    }
//}
