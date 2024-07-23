import Foundation
import Fluent


struct LogMigration:AsyncMigration{
    func prepare(on database:Database) async throws{
        try await database.schema("log")
            .field("id",.int,.identifier(auto:true))
            .field("trip_id",.int,.required,.references("trip", "id"))
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
