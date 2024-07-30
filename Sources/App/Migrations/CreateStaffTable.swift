import Foundation
import Fluent


struct StaffMigration: AsyncMigration {
    func prepare(on database: Database) async throws { //Use this function to create a table
        // Make a change to the database.
        try await database.schema("staff")
            .id()
            .field("name", .string, .required)
            .field("email", .string, .required)
            .field("password_hash", .string, .required)
            .unique(on: "email")
            .create()
            
    }

    func revert(on database: Database) async throws  { //Used to delete movies table
        // Undo the change made in `prepare`, if possible.
        try await database.schema("staff").delete()

    }
    
    
}
