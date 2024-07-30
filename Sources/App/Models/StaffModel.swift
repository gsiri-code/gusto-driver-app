//
//  File.swift
//  
//
//  Created by George Sirichartchai on 7/26/24.
//

import Fluent
import struct Foundation.UUID
import Vapor


final class Staff:Model, Content{
    static let schema = "staff"

    @ID(key:.id)
    var id:UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "email")
    var email: String

    @Field(key: "password_hash")
    var passwordHash: String
    
    init() { }
    
    init(id: UUID? = nil, name: String, email: String, passwordHash: String) {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
    }
}


extension Staff {
    struct Create: Content {
        var name: String
        var email: String
        var password: String
        var confirmPassword: String
    }
}


extension Staff.Create: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("name", as: String.self, is: !.empty)
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(8...))
    }
}

extension Staff: ModelAuthenticatable {
    static let usernameKey = \Staff.$email
    static let passwordHashKey = \Staff.$passwordHash

    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }
}

