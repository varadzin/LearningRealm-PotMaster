/// Copyright (c) 2022 Razeware LLC
/// 
///

import RealmSwift
import SwiftUI

struct IngredientFormView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.realm) var realm

  @ObservedRealmObject var ingredient: Ingredient

  let quantityOptions = [1, 2, 3, 4, 5]

  var isUpdating: Bool {
    // TODO: Mark as updating
    return false
  }

  var body: some View {
    NavigationView {
      Form {
        TextField("Title", text: $ingredient.title)
        Picker("Quantity", selection: $ingredient.quantity) {
          ForEach(quantityOptions, id: \.self) { option in
            Text("\(option)")
          }
        }
        // TODO: Add Color Picker
        Section("Notes📝") {
          TextEditor(text: $ingredient.notes)
        }
      }
      .navigationTitle("Ingredient Form")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button(isUpdating ? "Done" : "Save") {
            if isUpdating {
              dismiss()
            } else {
              save()
            }
          }
          .disabled(ingredient.title.isEmpty)
        }
      }
    }
  }
}

// MARK: - Actions
extension IngredientFormView {
  func save() {
    // TODO: Save ingredient
    dismiss()
  }
}

struct IngredientFormView_Previews: PreviewProvider {
  static var previews: some View {
    IngredientFormView(ingredient: Ingredient())
    IngredientFormView(ingredient: IngredientMock.ingredientsMock[0])
  }
}
