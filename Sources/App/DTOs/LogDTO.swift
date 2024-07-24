//
//  File.swift
//  
//
//  Created by George Sirichartchai on 7/24/24.
//

import Foundation
import Fluent
import Vapor


struct PatchLog: Decodable{
    var id:Int?
    var trip_id: Int?
    var driver_id:UUID?
    var address:String?
    var remark: String?
    
    func toModel(_ model:inout Log){
        if let id = self.id { model.id = id}
        
        if let trip_id = self.trip_id { model.trip_id = trip_id}
        
        if let driver_id = self.driver_id { model.driver_id = driver_id}
        
        if let address = self.address { model.address = address}
        
        if let remark = self.remark { model.remark = remark}
    }
}
