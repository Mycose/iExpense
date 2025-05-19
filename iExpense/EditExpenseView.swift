//
//  AddView.swift
//  iExpense
//
//  Created by Clément on 09/04/2025.
//

import SwiftUI

struct EditExpenseView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var expense: ExpenseItem

    let types = ["Personnal", "Business"]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $expense.type, content: {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                })
                TextField("Amount", value: $expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($expense.name)
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
                        dismiss()
                    }
                }

            }
        }
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var previewExpense = ExpenseItem(id: UUID(), name: "Preview", type: "Personnal", amount: 100)

    var body: some View {
        EditExpenseView(expense: $previewExpense)
    }
}
