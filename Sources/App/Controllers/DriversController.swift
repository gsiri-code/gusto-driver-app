import Vapor



struct DriversController: RouteCollection{
    func boot(routes:RoutesBuilder)throws{
        let driver = routes.grouped("driver")
        driver.get(use:readAll)
        driver.post(use:create)
        
        driver.group(":id"){ driver in
            driver.get(use:read)
            driver.put(use:update)
            driver.patch(use:edit)
            driver.delete(use:delete)
        }
    }
    
    // POST
    @Sendable func create(req:Request) async throws -> Driver {
        let driver = try req.content.decode(Driver.self)
        try await driver.save(on:req.db)
        return driver
    }
    
    // GET
    @Sendable func readAll(req:Request) async throws -> [Driver]{
        try await Driver.query(on: req.db).all()
    }
    
    // FIND
    @Sendable func read(req:Request) async throws -> Driver {
        guard let driver = try await Driver.find(req.parameters.get("id"),on:req.db) else {
            throw Abort(.notFound)
        }
        return driver
    }
    
    // PUT
    @Sendable func update(req:Request) async throws -> Driver {
        guard let driver = try await Driver.find(req.parameters.get("id"),on:req.db) else{
            throw Abort(.notFound)
        }
        let updatedDriver = try req.content.decode(Driver.self)
        
        driver.id = updatedDriver.id
        driver.name = updatedDriver.name
        driver.password = updatedDriver.password
        
        try await driver.save(on:req.db)
        return driver
    }
    
    // PATCH
    @Sendable func edit(req:Request) async throws -> Driver{
        // Decode the request data
        let patchData = try req.content.decode(PatchDriver.self)
        // Fetch desired driver from db
        guard var driver = try await Driver.find(req.parameters.get("id"),on:req.db) else {
            throw Abort(.notFound)
        }
        // Edit field(s)
        patchData.toModel(&driver)
        
        // Save to db
        try await driver.save(on:req.db)
        return driver
    }
    
    // DELETE
    @Sendable func delete(req:Request) async throws -> HTTPStatus {
        guard let driver = try await Driver.find(req.parameters.get("id"),on:req.db) else{
            throw Abort(.notFound)
        }
        try await driver.delete(on:req.db)
        return .ok
    }
    
    
    
    
    
}
