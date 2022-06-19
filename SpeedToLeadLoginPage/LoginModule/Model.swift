//
//  Model.swift
//  SpeedToLeadLoginPage
//
//  Created by Evgeniy Chernyshov on 18.06.2022.
//



import Foundation

// MARK: - UserModel

struct UserModel: Codable {
    let token: String
    let user: User
}

// MARK: - User

struct User: Codable {
    let smartParams: [JSONAny]
    let phoneValidated: Bool
    let credentials: [JSONAny]
    let removed: Bool
    let utmContent: JSONNull?
    let surname, state: String
    let timezone: JSONNull?
    let leadSubscribeSMS: Bool
    let fbUserRef: JSONNull?
    let subscribeSMS: [String]
    let dateUpdated: Int
    let socialImage: JSONNull?
    let hideDemoLead: Bool
    let subscribeEmails: [String]
    let dateCreated: Int
    let county: County
    let whHeaders: [JSONAny]
    let affiliation, stripeCustomer, stripeCardDefault, image: JSONNull?
    let preferedStates, showSmart: Bool
    let bio: JSONNull?
    let role: String
    let authSource: JSONNull?
    let emailValidated: Bool
    let utmSource: JSONNull?
    let name: String
    let counties: [JSONAny]
    let birthDate: JSONNull?
    let whActive: Bool
    let paypalEmail: JSONNull?
    let leadSubscribe: Bool
    let currentEntity: String
    let passwordAssigned: Bool
    let email: String
    let balance: Int
    let pushTokenUpdated: JSONNull?
    let states: [String]
    let id: String
    let hideDemoOrder, cookiesAgree: Bool
    let premiumTrialEnd, gender: JSONNull?
    let phone: String
    let wh: JSONNull?
    let visible: Bool
    let city, premiumEnd, utmTerm, utmMedium: JSONNull?
    let warrantyCount, privacyAgree: Int
    let free99: JSONNull?
    let lastLogin: Int
    let countiesSMS: [JSONAny]
    let utmCampaign: JSONNull?
    let lang: String
    let statesSMS: [String]
    let cards: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case smartParams = "smart_params"
        case phoneValidated = "phone_validated"
        case credentials, removed
        case utmContent = "utm_content"
        case surname, state, timezone
        case leadSubscribeSMS = "lead_subscribe_sms"
        case fbUserRef = "fb_user_ref"
        case subscribeSMS = "subscribe_sms"
        case dateUpdated = "date_updated"
        case socialImage = "social_image"
        case hideDemoLead = "hide_demo_lead"
        case subscribeEmails = "subscribe_emails"
        case dateCreated = "date_created"
        case county
        case whHeaders = "wh_headers"
        case affiliation
        case stripeCustomer = "stripe_customer"
        case stripeCardDefault = "stripe_card_default"
        case image
        case preferedStates = "prefered_states"
        case showSmart = "show_smart"
        case bio, role
        case authSource = "auth_source"
        case emailValidated = "email_validated"
        case utmSource = "utm_source"
        case name, counties
        case birthDate = "birth_date"
        case whActive = "wh_active"
        case paypalEmail = "paypal_email"
        case leadSubscribe = "lead_subscribe"
        case currentEntity = "current_entity"
        case passwordAssigned = "password_assigned"
        case email, balance
        case pushTokenUpdated = "push_token_updated"
        case states
        case id = "_id"
        case hideDemoOrder = "hide_demo_order"
        case cookiesAgree = "cookies_agree"
        case premiumTrialEnd = "premium_trial_end"
        case gender, phone, wh, visible, city
        case premiumEnd = "premium_end"
        case utmTerm = "utm_term"
        case utmMedium = "utm_medium"
        case warrantyCount = "warranty_count"
        case privacyAgree = "privacy_agree"
        case free99
        case lastLogin = "last_login"
        case countiesSMS = "counties_sms"
        case utmCampaign = "utm_campaign"
        case lang
        case statesSMS = "states_sms"
        case cards
    }
}

// MARK: - County

struct County: Codable {
    let fips: Int
    let id: String
    let population, v: Int
    let stateID, currentEntity, name: String

    enum CodingKeys: String, CodingKey {
        case fips
        case id = "_id"
        case population
        case v = "__v"
        case stateID = "state_id"
        case currentEntity = "current_entity"
        case name
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
