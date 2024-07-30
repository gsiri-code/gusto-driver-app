import Fluent


struct StaffTokenMigration: AsyncMigration {
    var name: String { "CreateStaffToken" }

    func prepare(on database: Database) async throws {
        try await database.schema("staff_tokens")
            .id()
            .field("value", .string, .required)
            .field("staff_id", .uuid, .required, .references("staff", "id"))
            .unique(on: "value")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("staff_tokens").delete()
    }
}

