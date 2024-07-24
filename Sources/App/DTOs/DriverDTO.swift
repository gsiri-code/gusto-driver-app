import Foundation
import Fluent
import Vapor

struct PatchDriver: Decodable{
    var id: UUID?
    var name: String?
    var password: String?
    
    func toModel(_ model:inout Driver){
        
        if let id = self.id {model.id = id}
        
        if let name = self.name {model.name = name}
        
        if let password = self.password {model.password = password}
        
    }
}
