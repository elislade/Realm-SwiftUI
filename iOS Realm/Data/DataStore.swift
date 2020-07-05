import Combine
import RealmSwift

final class DataStore: ObservableObject {
    
    private var todoCancellable:AnyCancellable?
    private(set) var todoDB = DataObservable<Todo>()
    
    @Published private(set) var todos:[Todo] = []
    
    init() {
        todoDB = DataObservable<Todo>()
        todoCancellable = todoDB.$items.assign(to: \.todos, on: self)
    }
}
