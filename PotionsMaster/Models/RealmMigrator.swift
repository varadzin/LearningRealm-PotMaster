/// Copyright (c) 2022 Razeware LLC

import RealmSwift

enum RealmMigrator {
  static private func migrationBlock(
    migration: Migration,
    oldSchemaVersion: UInt64
  ) {
    if oldSchemaVersion < 1 {
      migration.enumerateObjects(ofType: Ingredient.className()) { _, newObject in
        newObject?["colorOption"] = ColorOptions.green
      }
    }
  }

  static var configuration: Realm.Configuration {
    Realm.Configuration(schemaVersion: 1, migrationBlock: migrationBlock)
  }
}
