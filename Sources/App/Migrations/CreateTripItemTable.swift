//
//  File.swift
//  
//
//  Created by George Sirichartchai on 7/23/24.
//

import Foundation
import Fluent
import Vapor

struct TripItemMigration: AsyncMigration{
    func prepare(on database:Database) async throws{
        try await database.schema("trip_item")
            .field("id",.int,.identifier(auto:true))
            .field("company",.string)
            .field("trip_id",.int,.required,.references("trip", "id"))
            .field("stop_no",.string)
            .field("rep",.string)
            .field("total_weight",.int)
            .field("pick",.int)
            .field("qty",.int)
            .field("invoice_no",.string)
            .field("remarks",.string)
            .ignoreExisting()
            .create()
    }
    func revert(on database: Database) async throws{
        try await database.schema("trip_item").delete()
    }
}
