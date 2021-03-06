// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userRegister = try? newJSONDecoder().decode(UserRegister.self, from: jsonData)

import Foundation

// MARK: - UserRegister
struct UserRegister: Codable {
    let user: [User]?
}

// MARK: - User
struct User: Codable {
    let durum: Bool?
    let mesaj, kullaniciId: String?

    enum CodingKeys: String, CodingKey {
        case durum, mesaj
        case kullaniciId 
    }
}
