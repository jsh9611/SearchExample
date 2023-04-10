//
//  SearchBooksView.swift
//  SearchExample
//
//  Created by SeongHoon Jang on 2023/04/08.
//

import SwiftUI

struct SearchBooksView: View {
    @ObservedObject var vm: SearchBooksViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Bookmark.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Bookmark.title, ascending: true)])
    private var bookmarks: FetchedResults<Bookmark>
    
    private func isBookmarked(_ isbn13: String) -> Bool {
        bookmarks.contains { $0.isbn13 == isbn13 }
    }
    
    let isTextEmpty: Bool
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            
            if isTextEmpty {
                ForEach(bookmarks, id: \.self) { bookmark in
                    let book = bookmarkToBooks(bookmark)
                    
                    ZStack(alignment: .trailing) {
                        NavigationLink(destination: Text("Detail")) {
                            
                            bookListCell(book: book)
                                .onAppear {
                                    if let last = vm.books.last {
                                        if last.isbn13 == book.isbn13 {
                                            vm.loadOnePage()
                                        }
                                    }
                                }
                        }
                        
                        bookmarkToggle(book: book)
                            .offset(x: -16, y: 28)
                    }
                }
            } else {
                ForEach(vm.books, id: \.self) { book in
                    
                    ZStack(alignment: .trailing) {
                        NavigationLink(destination: Text("Detail")) {
                            
                            bookListCell(book: book)
                                .onAppear {
                                    if let last = vm.books.last {
                                        if last.isbn13 == book.isbn13 {
                                            vm.loadOnePage()
                                        }
                                    }
                                }
                        }
                        bookmarkToggle(book: book)
                            .offset(x: -16, y: 28)
                    }
                }
            }
        }
        .foregroundColor(.black)
    }
}

//MARK: - 컴포넌트 추가
private extension SearchBooksView {
    
    /// 북마크를 추가/삭제할 수 있는 하트모양 버튼
    @ViewBuilder
    func bookmarkToggle(book: Books) -> some View {
        
        Button(action: { toggleBookmark(book) }) {
            VStack {
                Image(systemName: isBookmarked(book.isbn13) ? "heart.fill" : "heart")
                    .resizable()
                
                    .foregroundColor(isBookmarked(book.isbn13) ? .red : .gray)
                
            }
            .frame(width: 25, height: 25)
            .contentShape(Rectangle())
        }
    }
    
    /// 책 리스트의 Cell
    @ViewBuilder
    func bookListCell(book: Books) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.crop.square")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.trailing, 8)
                    .cornerRadius(15)
                
                VStack {
                    Text("\(book.title)")
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    HStack {
                        Text("\(book.price)")
                            .bold()
                        Spacer()
                    }
                    
                }
                .padding(.vertical, 8)
            }
            
            Divider()
        }
        .padding(.horizontal, 16)
    }
}

//MARK: - CoreData 기능
private extension SearchBooksView {
    
    // CoreData 변경사항 저장
    func saveItems() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // Bookmark(NSManagedObject)에 저장
    func saveBookmark(book: Books) {
        let bookmark = Bookmark(context: viewContext)
        bookmark.title = book.title
        bookmark.subtitle = book.subtitle
        bookmark.isbn13 = book.isbn13
        bookmark.price = book.price
        bookmark.image = book.image
        bookmark.url = book.url
    }
    
    /// CoreData에 북마크를 추가/제거 합니다
    func toggleBookmark(_ book: Books) {
        if let bookmark = bookmarks.first(where: { $0.isbn13 == book.isbn13 }) {
            withAnimation {
                viewContext.delete(bookmark)
            }
        } else {
            saveBookmark(book: book)
        }
        
        saveItems()
    }
    
    // bookmark타입을 books 타입으로 변경
    func bookmarkToBooks(_ bookmark: Bookmark) -> Books {
        return Books(
            title: bookmark.title ?? "",
            subtitle: bookmark.subtitle ?? "",
            isbn13: bookmark.isbn13 ?? "",
            price: bookmark.price ?? "",
            image: bookmark.image ?? "",
            url: bookmark.url ?? "")
    }
}
