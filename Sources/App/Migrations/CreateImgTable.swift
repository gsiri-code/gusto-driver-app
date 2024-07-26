//
//  File.swift
//  
//
//  Created by George Sirichartchai on 7/25/24.
//

import Foundation
import Fluent
import Vapor

struct LogImageMigration:AsyncMigration{
    func prepare(on database: Database) async throws {
        try await database.schema("imgs")
            .field("id",.int,.identifier(auto:true))
            .field("log_id",.int,.required,.references("log", "id"))
            .field("src",.string)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("imgs").delete()
    }
}
