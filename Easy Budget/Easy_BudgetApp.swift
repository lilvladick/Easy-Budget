//
//  Easy_BudgetApp.swift
//  Easy Budget
//
//  Created by Владислав Кириллов on 28.07.2024.
//

import SwiftUI
import SwiftData

@main
struct Easy_BudgetApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Account.self, Operation.self, Category.self )
        } catch {
            fatalError("Initialize error: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            HomeScreenView()
        }
        .modelContainer(container)
    }
}
