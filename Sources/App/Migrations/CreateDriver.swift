
import Foundation
import Fluent


struct DriverMigration: AsyncMigration {
    func prepare(on database: Database) async throws { //Use this function to create a table
        // Make a change to the database.
        try await database.schema("driver")
            .id()
            .field("name", .string, .required)
            .field("password", .string, .required)
            .unique(on:"name")
            .create()
    }

    func revert(on database: Database) async throws  { //Used to delete movies table
        // Undo the change made in `prepare`, if possible.
    }
}
