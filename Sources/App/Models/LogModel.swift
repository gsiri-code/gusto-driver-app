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


final class Log:Model,Content{
    static let schema: String = "log"
    
    @ID(custom:"id",generatedBy: .database)
    var id:Int?
    
    @Field(key:"driver_id")
    var driver_id:UUID
    
    @Field(key:"location")
    var address:String
    
    @Field(key:"remark")
    var remark:String
    
    @Timestamp(key: "deliver_date", on: .create, format: .iso8601)
    var deliver_date: Date?
    
    init(){}
    
    init(id:Int,driver_id:UUID,address:String,remark:String,deliver_date: Date = Date.now){
        self.id = id
        self.driver_id = driver_id
        self.address = address
        self.remark = remark
        self.deliver_date = deliver_date
    }
    
    
    
}
