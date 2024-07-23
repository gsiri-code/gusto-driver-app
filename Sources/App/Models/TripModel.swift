//
//  File.swift
//
//
//  Created by George Sirichartchai on 7/22/24.
//

import Fluent
import struct Foundation.UUID
import Vapor
import Foundation

final class Trip: Model, Content{
    static let schema: String = "trip"
    
    @ID(custom:"id",generatedBy: .database)
    var id:Int?
    
    @Field(key:"trip_name")
    var trip_name:String
    
    @Field(key:"ship_date")
    var ship_date: Date
    
    @Field(key: "ship_via")
    var ship_via:String
    
    @Field(key: "driver_id")
    var driver:UUID
    
    @Field(key:"total_weight")
    var total_weight:Double
    
    @Field(key:"remark")
    var remark:String
    
    @Field(key:"progress")
    var progress:String
    
    @Field(key:"pick")
    var pick:Int
    
    @Field(key:"qty")
    var qty:Int
    
    init(){}
    
    init    (id:Int?=nil,trip_name:String,ship_date:Date,ship_via:String,driver:UUID,total_weight:Double,remark:String,progress:String
                 ,pick:Int,qty:Int){
        self.id = id
        self.trip_name = trip_name
        self.ship_date = ship_date
        self.ship_via = ship_via
        self.driver = driver
        self.total_weight = total_weight
        self.remark = remark
        self.progress = progress
        self.pick = pick
        self.qty = qty
    }
    
    
    
    
}
