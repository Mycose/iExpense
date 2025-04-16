//
//  Expense.swift
//  iExpense
//
//  Created by Clément on 10/03/2025.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "expenses")
            }
        }
    }
    
    init() {
        if let savedExpenses = UserDefaults.standard.data(forKey: "expenses") {
            if let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: savedExpenses) {
                items = decoded
                return
            }
        }
        items = []
    }
}
