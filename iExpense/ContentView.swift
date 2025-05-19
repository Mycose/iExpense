//
//  ContentView.swift
//  iExpense
//
//  Created by Clément on 10/03/2025.
//

import SwiftUI

struct ItemView: View {
    @Binding var item: ExpenseItem
    
    var body: some View {
        NavigationLink {
            EditExpenseView(expense: $item)
        } label: {
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
                        ForEach(expenses.items.indices.filter { expenses.items[$0].type == "Business" }, id: \.self) { index in
                            ItemView(item: $expenses.items[index])
                        }
                        .onDelete(perform: removeBusinessItems)
                    }
                }
                
                if !personnalExpenses.isEmpty {
                    Section("Personnal") {
                        ForEach(expenses.items.indices.filter { expenses.items[$0].type == "Personnal" }, id: \.self) { index in
                            ItemView(item: $expenses.items[index])
                        }
                        .onDelete(perform: removePersonalItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink(destination: AddExpenseView(expenses: expenses), label: {
                    Text("Add new expense")
                    Image(systemName: "plus")
                })
            }
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
            let businessIndices = expenses.items.indices.filter { expenses.items[$0].type == "Business" }
            let actualIndices = offsets.map { businessIndices[$0] }
            for index in actualIndices.sorted(by: >) {
                expenses.items.remove(at: index)
            }
        }

        func removePersonalItems(at offsets: IndexSet) {
            let personalIndices = expenses.items.indices.filter { expenses.items[$0].type == "Personnal" }
            let actualIndices = offsets.map { personalIndices[$0] }
            for index in actualIndices.sorted(by: >) {
                expenses.items.remove(at: index)
            }
        }
}

#Preview {
    ContentView()
}
