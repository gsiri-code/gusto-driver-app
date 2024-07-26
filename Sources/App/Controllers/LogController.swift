//
//  File.swift
//
//
//  Created by George Sirichartchai on 7/23/24.
//


import Vapor
import Fluent


struct LogController: RouteCollection{
    func boot(routes:RoutesBuilder) throws {
        let logs = routes.grouped("log")
        logs.get(use:readAll)
        logs.post(use:create)
        
        logs.group(":id"){log in
            log.get(use:read)
            log.put(use:update)
            log.patch(use:edit)
            log.delete(use:delete)
            log.get("img",use:getImg)
            log.post("img",":src",use:addImg)
            log.delete("img",":ImgId",use:delImg)
        }
        
    }
    
    // POST
    @Sendable func create(req:Request) async throws -> Log{
        let log = try req.content.decode(Log.self)
        try await log.save(on:req.db)
        return log
    }
    @Sendable func create(req: Request) throws -> EventLoopFuture<Log> {
        let log = try req.content.decode(Log.self)
        return log.save(on: req.db).map { log }
    }
    
    // GET
    @Sendable func readAll(req:Request) async throws -> [Log]{
        try await Log.query(on: req.db).all()
    }
    
    // FIND
    @Sendable func read(req: Request) async throws -> Log {
        guard let log = try await Log.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return log
    }
    
    // PUT
    @Sendable func update(req: Request) async throws -> Log {
        guard let log = try await Log.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let updatedlog = try req.content.decode(Log.self)
        log.trip_id = updatedlog.trip_id
        log.driver_id = updatedlog.driver_id
        log.address = updatedlog.address
        log.remark = updatedlog.remark
        log.deliver_date = updatedlog.deliver_date
        try await log.save(on: req.db)
        return log
    }
    
    // PATCH
    @Sendable func edit(req:Request) async throws -> Log{
        // Decode Request data
        let patchData = try req.content.decode(PatchLog.self)
        // Fetch desired driver from DB
        guard var log = try await Log.find(req.parameters.get("id"),on:req.db) else{
            throw Abort(.notFound)
        }
        // Edit Field(s)
        patchData.toModel(&log)
        // Save to db
        try await log.save(on: req.db)
        return log
    }
    
    // DELETE
    @Sendable func delete(req: Request) async throws -> HTTPStatus {
        guard let log = try await Log.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await log.delete(on: req.db)
        return .ok
    }
    
    // IMG OPERATIONS
    
    // GET imgs
    @Sendable func getImg(req:Request) async throws -> [Img]{
        
        let stringLogId = req.parameters.get("id")
        
        let LogId = Int(stringLogId!)!

        guard let res =  try await Log.query(on: req.db).filter(\.$id == LogId).with(\.$Imgs).first() else{
            throw Abort(.notFound)
        }
        
        return res.Imgs
        
    }
    
    // Add new imgs
    @Sendable func addImg(req:Request) async throws -> Log {
        let stringLogId = req.parameters.get("id")
        let newSrc = req.parameters.get("src")!
        
        let LogId = Int(stringLogId!)!

        guard let log =  try await Log.query(on: req.db).filter(\.$id == LogId).with(\.$Imgs).first() else{
            throw Abort(.notFound)
        }
        
        let newImg = Img(log_id: LogId, src:newSrc)
        try await log.$Imgs.create(newImg, on: req.db)
        
        try await log.save(on: req.db)
        return log
    }
    
    // Delete Images
    @Sendable func delImg(req:Request) async throws -> HTTPStatus {
        guard let img = try await Img.find(req.parameters.get("ImgId"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await img.delete(on: req.db)
        return .ok
    }
}

