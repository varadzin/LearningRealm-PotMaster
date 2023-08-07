/// Copyright (c) 2022 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import RealmSwift

struct IngredientFormView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.realm) var realm

  @ObservedRealmObject var ingredient: Ingredient

  let quantityOptions = [1, 2, 3, 4, 5]
  let colorOptions = ColorOptions.allCases

  var isUpdating: Bool {
    ingredient.realm != nil
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
        Picker("Color", selection: $ingredient.colorOption) {
          ForEach(colorOptions, id: \.self) { option in
            Text(option.title)
          }
        }
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
    try? realm.write {
      realm.add(ingredient)
    }
    dismiss()
  }
}

struct IngredientFormView_Previews: PreviewProvider {
  static var previews: some View {
    IngredientFormView(ingredient: Ingredient())
    IngredientFormView(ingredient: IngredientMock.ingredientsMock[0])
  }
}
