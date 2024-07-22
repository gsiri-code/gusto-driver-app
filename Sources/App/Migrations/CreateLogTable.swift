//
//  File.swift
//  
//
//  Created by George Sirichartchai on 7/22/24.
//

import Foundation
import Fluent


struct LogMigration:AsyncMigration{
    func prepare(on database:Database) async throws{
        try await database.schema("log")
            .field("id",.int,.identifier(auto:true))
            .field("driver_id",.uuid,.required,.references("driver", "id"))
            .field("address",.string,.required)
            .field("deliver_date",.datetime,.required)
            .field("remarks",.string)
            .create()
    }
    
    func revert(on database:Database) async throws{
        
        try await database.schema("log").delete()

        
    }
    
        
}
