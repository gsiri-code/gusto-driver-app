import Foundation
import Fluent
import Vapor


struct TripMigration:AsyncMigration{
    func prepare(on database:Database) async throws{
        try await database.schema("trip")
            .field("id",.int,.identifier(auto:true))
            .field("trip_name",.string)
            .field("ship_date",.date)
            .field("ship_via",.string)
            .field("driver_id",.uuid,.required,.references("driver", "id"))
            .field("total_weight",.double)
            .field("remark",.string)
            .field("progress",.string)
            .field("pick",.int)
            .field("qty",.int)
            .create()

    }
    
    func revert(on database:Database) async throws{
        try await database.schema("trip").delete()
    }

}
