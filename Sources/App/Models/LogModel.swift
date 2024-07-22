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
    
    @ID(key:.id)
    var id:UUID?
    
    @Field(key:"driver_name")
    var driver_name:String
    
    @Field(key:"location")
    var location:String
    
    @Field(key:"remark")
    var remark:String
    
    @Timestamp(key: "deliver_date", on: .create, format: .iso8601)
    var deliver_date: Date?
    
    init(){}
    
    init(id:UUID? = nil,driver_name:String,location:String,remark:String,deliver_date: Date?){
        self.id = id
        self.driver_name = driver_name
        self.location = location
        self.remark = remark
        self.deliver_date = deliver_date
    }
    
    
    
}
