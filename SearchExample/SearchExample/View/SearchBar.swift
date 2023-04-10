//
//  SearchBar.swift
//  SearchExample
//
//  Created by SeongHoon Jang on 2023/04/09.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var vm: SearchBooksViewModel
    @Binding var text : String
    
    @State var isTextFieldFocused : Bool = false  // 텍스트필드 클릭했는지 체크
     
     // 최근 검색어 목록을 로드하는 computed property
     var recentSearches: [String] {
         UserDefaults.standard.array(forKey: UserKeys.recentSearchesKey.rawValue) as? [String] ?? []
     }
    
    var body: some View {
        HStack {
            TextField("검색어를 넣어주세요" , text : self.$text)
                .padding(16)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(15)
            
                .keyboardType(.default)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
                .overlay(
                    HStack {
                        Spacer()
                        // 텍스트 필드를 눌렀다면 텍스트 입력 모드
                        if self.isTextFieldFocused{
                            
                            Button(action : {
                                // 다른 검색어를 입력한 경우
                                if !text.isEmpty && vm.word != text {
                                    vm.clearAllData()
                                    
                                    vm.word = self.text
                                    
                                    vm.loadOnePage()
                                    saveSearchWord()
                                }
                                disableKeyboard()
                            }){
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color(.black))
                                    .padding()
                            }
                            
                        } else {
                            // 텍스트 필드가 비활성화된 상태
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(.black))
                                .padding()
                        }
                    }
                )
                .onTapGesture {
                    self.text = ""
                    self.isTextFieldFocused = true
                }
        }
        .padding(.horizontal, 16)
    }
    
    /// 키 입력 이벤트를 종료. 키보드 비활성화
    private func disableKeyboard() {
        self.isTextFieldFocused = false
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
    
    // 검색어를 최근 검색어 목록에 추가하고 저장
    private func saveSearchWord() {
        guard !text.isEmpty else { return }
        
        // 중복 검색어 제거를 위해 기존 목록에서 해당 검색어를 제거
        var searches = recentSearches.filter { $0 != text }
        
        // 새 검색어를 목록 맨 앞에 추가
        searches.insert(text, at: 0)
        
        // 최근 검색어 목록을 UserDefaults에 저장
        UserDefaults.standard.set(searches, forKey: UserKeys.recentSearchesKey.rawValue)
    }
}
