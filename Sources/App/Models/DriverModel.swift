import Fluent
import struct Foundation.UUID
import Vapor
import Foundation


final class Driver: Model, Content{
    static let schema = "driver"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "password")
    var password: String

    init(){}

    init(id: UUID? = nil) {
        self.id = id
        self.name = name
        self.password = password
    }
    
}
