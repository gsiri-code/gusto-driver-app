import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

public func configure(_ app: Application) async throws {

    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: "localhost",
        port: 6000,
        username: "iminthecoupwiththecutta",
        password: "6200",
        database: "postgres",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)
    
    // Schema Builders
    app.migrations.add(DriverMigration())
    app.migrations.add(TripMigration())
    app.migrations.add(LogMigration())
    app.migrations.add(TripItemMigration())

    try routes(app)
}
