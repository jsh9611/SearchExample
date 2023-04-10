//
//  SearchExampleApp.swift
//  SearchExample
//
//  Created by SeongHoon Jang on 2023/04/06.
//

import SwiftUI

@main
struct SearchExampleApp: App {
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
