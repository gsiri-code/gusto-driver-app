import Fluent
import Foundation
import Vapor

func routes(_ app: Application) throws {
    
    
    try app.register(collection: DriversController())
    try app.register(collection:LogController())
    try app.register(collection:StaffController())
    
    let passwordProtected = app.grouped(Staff.authenticator())
    passwordProtected.post("staff-login"){req -> StaffToken in
        let staff = try req.auth.require(Staff.self)
        let token = try staff.generateToken()
        try await token.save(on:req.db)
        return token
    }
    
    let tokenProtected = app.grouped(StaffToken.authenticator())
    tokenProtected.get("staff-token") { req ->  Staff in
        try req.auth.require(Staff.self)
    }
    
}
