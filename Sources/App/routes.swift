import Fluent
import Foundation
import Vapor

func routes(_ app: Application) throws {
    
    try app.register(collection: DriversController())
    

}
