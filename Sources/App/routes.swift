import Fluent
import Foundation
import Vapor

func routes(_ app: Application) throws {
    
    
    try app.register(collection: DriversController())
    try app.register(collection:LogController())
    try app.register(collection:StaffController())
    
    let passwordProtected = app.grouped(Staff.authenticator())
    passwordProtected.post("login"){req -> Staff in
        try req.auth.require(Staff.self)}

}
