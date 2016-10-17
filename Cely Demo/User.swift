//
//  User.swift
//  Cely
//
//  Created by Fabian Buentello on 10/15/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation
import Cely

struct User: CelyUser {

    private init() {}
    static let ref = User()

    enum Property: CelyProperty {
        case Username = "username"
        case Email = "email"
        case Token = "token"

        func securely() -> Bool {
            switch self {
            case .Token:
                return true
            default:
                return false
            }
        }

        func save(_ value: Any) {
            Cely.save(value, forKey: rawValue, securely: securely())
        }

        func get() -> Any? {
            return Cely.get(key: rawValue)
        }
    }
}

// MARK: - Save/Get User Properties

extension User {

    static func save(value: Any, as property: Property) {
        property.save(value: value)
    }

    static func save(data: [Property : Any]) {
        data.forEach { property, value in
            property.save(value)
        }
    }

    static func get(property: Property) -> Any? {
        return property.get()
    }
}