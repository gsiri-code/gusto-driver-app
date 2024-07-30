//
//  File.swift
//
//
//  Created by George Sirichartchai on 7/26/24.
//

import Foundation
import Vapor


struct StaffController: RouteCollection{
    func boot(routes:RoutesBuilder)throws{
        
        let staff = routes.grouped("staff")
        staff.get(use:readAll)
        staff.post(use:create)
        
        //        staff.group(":id"){ staff in
        //            staff.get(use:read)
        //            staff.put(use:update)
        //            staff.patch(use:edit)
        //            staff.delete(use:delete)
        //        }
    }
    
    @Sendable func create(req:Request)  async throws -> Staff{
        try Staff.Create.validate(content:req)
        let create = try req.content.decode(Staff.Create.self)
        guard create.password == create.confirmPassword else{
            throw Abort(.badRequest,reason: "Passwords do not match")
        }
        let staff = try Staff(
            name:create.name,
            email:create.email,
            passwordHash:Bcrypt.hash(create.password)
        )
        try await staff.save(on: req.db)
        return staff
    }
    
    
    
    @Sendable func readAll(req:Request) async throws ->[Staff]{
        return try await Staff.query(on: req.db).all()
    }
}


