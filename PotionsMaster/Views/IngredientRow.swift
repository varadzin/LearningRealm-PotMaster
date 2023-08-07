/// Copyright (c) 2022 Razeware LLC
/// 
/// 
import SwiftUI

struct IngredientRow: View {
  @State private var ingredientFormIsPresented = false
  let ingredient: Ingredient

  var buttonImage: String {
    ingredient.bought ? "circle.inset.filled" : "circle"
  }

  var body: some View {
    HStack {
      Button(action: openUpdateIngredient) {
        Text("\(ingredient.quantity)")
          .bold()
          .padding(.horizontal, 4)
        VStack(alignment: .leading) {
          Text(ingredient.title)
            .font(.headline)
          Text(ingredient.notes)
            .font(.subheadline)
        }
        .lineLimit(1)
      }
      .buttonStyle(.plain)
      .disabled(ingredient.bought)
      .sheet(isPresented: $ingredientFormIsPresented) {
        IngredientFormView(ingredient: ingredient)
      }
      Spacer()
      Button(action: toggleBought) {
        Image(systemName: buttonImage)
          .resizable()
          .frame(width: 24, height: 24)
      }
    }
  }
}

// MARK: - Actions
extension IngredientRow {
  func openUpdateIngredient() {
    ingredientFormIsPresented.toggle()
  }

  func toggleBought() {
    // TODO: Toggle bought
  }
}

struct IngredientRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      IngredientRow(ingredient: IngredientMock.ingredientsMock[0])
      IngredientRow(ingredient: IngredientMock.boughtIngredientsMock[0])
    }
    .previewLayout(.sizeThatFits)
  }
}
