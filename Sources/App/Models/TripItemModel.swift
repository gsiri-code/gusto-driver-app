//
//  File.swift
//  
//
//  Created by George Sirichartchai on 7/22/24.
//

import Fluent
import struct Foundation.UUID
import Vapor


final class TripItem:Model,Content{
    static let schema = "trip_item"
    
    @ID(custom:"id",generatedBy: .database)
    var id:Int?
    
    @Field(key: "company")
    var company:String
    
    @Field(key: "stop_no")
    var stop_no:String
    
    @Field(key:"rep")
    var rep:String
    
    @Field(key:"total_weight")
    var total_weight: Int
    
    @Field(key:"pick")
    var pick:Int
    
    @Field(key:"qty")
    var qty:Int
    
    @Field(key:"invoice_no")
    var invoice_no:String
    
    @Field(key:"trip_id")
    var trip_id:Int
    
    @Field(key: "remarks")
    var remarks:String
    
    init() {}
    
    init(id: Int? = nil, company: String, stop_no: String, rep: String, total_weight: Int, pick: Int, qty: Int, invoice_no: String, trip_id: Int,remarks:String) {
        self.id = id
        self.company = company
        self.stop_no = stop_no
        self.rep = rep
        self.total_weight = total_weight
        self.pick = pick
        self.qty = qty
        self.invoice_no = invoice_no
        self.trip_id = trip_id
        self.remarks = remarks
    }
}
