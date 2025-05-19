//
//  AddView.swift
//  iExpense
//
//  Created by Clément on 09/04/2025.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "Expense"
    @State private var type = "Personnal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    
    let types = ["Personnal", "Business"]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type, content: {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                })
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let expense = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(expense)
                        dismiss()
                    }
                }

            }
        }
    }
}

#Preview {
    AddExpenseView(expenses: Expenses())
}
