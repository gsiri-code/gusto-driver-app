import Fluent
import Vapor

final class StaffToken: Model, Content {
    static let schema = "staff_tokens"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "value")
    var value: String

    @Parent(key: "staff_id")
    var user: Staff

    init() { }

    init(id: UUID? = nil, value: String, userID: Staff.IDValue) {
        self.id = id
        self.value = value
        self.$user.id = userID
    }
}



extension StaffToken: ModelTokenAuthenticatable {
    static let valueKey = \StaffToken.$value
    static let userKey = \StaffToken.$user

    var isValid: Bool {
        true
    }
}
