//
//  ContentView.swift
//  iExpense
//
//  Created by Clément on 10/03/2025.
//

import SwiftUI

struct ItemView: View {
    var item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            Spacer()
            
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
        .foregroundStyle(expenseForegroundColor(amount: item.amount))
    }
    
    func expenseForegroundColor(amount: Double) -> Color {
        if amount > 100 {
            return .green
        } else if amount > 10 {
            return .blue
        } else {
            return .red
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var personnalExpenses: [ExpenseItem] {
        return expenses.items.filter { $0.type == "Personnal" }
    }
    
    var businessExpenses: [ExpenseItem] {
        return expenses.items.filter { $0.type == "Business" }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if !businessExpenses.isEmpty {
                    Section("Business") {
                        ForEach(businessExpenses) { item in
                            ItemView(item: item)
                        }
                        .onDelete(perform: removeItems)
                    }
                }
                
                if !personnalExpenses.isEmpty {
                    Section("Personnal") {
                        ForEach(personnalExpenses) { item in
                            ItemView(item: item)
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add new expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense, content: {
                AddExpenseView(expenses: expenses)
            })
        }
    }
    
    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
