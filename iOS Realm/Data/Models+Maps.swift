import Foundation
import SwiftUI
import RealmSwift

protocol UUIDIdentifiable: Identifiable { var id:String { get } }
protocol Initializable { init() }


// MARK: - Backing Realm Data Object

class RealmTodo:Object, UUIDIdentifiable {
    @objc dynamic var id:String = UUID().uuidString
    @objc dynamic var content:String = ""
    @objc dynamic var dateCreated = Date()
    @objc dynamic var dateReminder:Date?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


// MARK: - Abstracted Data Struct which is what is presented with the UI

struct Todo: Equatable {
    var id:String = UUID().uuidString
    var content:String = ""
    var dateCreated = Date()
    var dateReminder:Date?
}


// MARK: - Map Between the Two

protocol RealmConvertible where Self:Equatable & UUIDIdentifiable & Initializable {
    associatedtype RealmType: Object & UUIDIdentifiable
    
    func realmMap() -> RealmType
    init(_ dest:RealmType)
}

// Dynamic Realm Binding for live data editing

extension RealmConvertible {
    func realmBinding() -> Binding<Self> {
        let h = RealmHelper()
        return Binding<Self>(get: {
            if let r = h.get(self.realmMap()) {
                // get the latest realm version for most uptodate data and map back to abstracted structs on init
                return Self(r)
            } else {
                // otherwise return self as it's the most uptodate version of the data struct
                return self
            }
        }, set: h.updateConvertible)
    }
}

extension RealmTodo {
    convenience init(_ obj: Todo) {
        self.init()
        self.id = obj.id
        self.content = obj.content
        self.dateCreated = obj.dateCreated
        self.dateReminder = obj.dateReminder
    }
}

extension Todo: RealmConvertible {
    func realmMap() -> RealmTodo {
        RealmTodo(self)
    }
    
    init(_ obj:RealmTodo) {
        self.id = obj.id
        self.content = obj.content
        self.dateCreated = obj.dateCreated
        self.dateReminder = obj.dateReminder
    }
}

