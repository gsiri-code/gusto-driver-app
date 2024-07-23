import Fluent
import struct Foundation.UUID
import Vapor



final class Driver: Model, Content{
    static let schema = "driver"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "password")
    var password: String

    init(){}

    init(id: UUID? = nil,name: String,password: String) {
        self.id = id
        self.name = name
        self.password = password
    }
    
}
