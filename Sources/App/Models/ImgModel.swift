//
//  File.swift
//  
//
//  Created by George Sirichartchai on 7/25/24.
//

import Fluent
import struct Foundation.UUID
import Vapor

final class Img: Model, Content{
    static let schema = "imgs"
    
    @ID(custom:"id",generatedBy: .database)
    var id:Int?
    
    @Parent(key: "log_id")
    var log:Log
    
    @Field(key: "src")
    var src:String
    
    init() {}
    init(id:Int?=nil,log_id:Int,src:String){
        self.id = id
        self.$log.id = log_id
        self.src = src
    }    
}
