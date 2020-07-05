import SwiftUI

struct TodoList: View {
    @EnvironmentObject var data:DataStore
    
    var body: some View {
        Group {
            if data.todos.count > 0 {
                ScrollView {
                    VStack(spacing:20){
                        ForEach(data.todos.sorted(by: { $0.dateCreated < $1.dateCreated })){ s in
                            TodoCell(todo: s.realmBinding())
                                .background(Color(.secondarySystemFill).opacity(0.5))
                                .cornerRadius(18)
                                .padding(.horizontal)
                                .transition(.cell)
                        }
                        Spacer()
                    }.padding(.vertical)
                }
            } else {
                VStack {
                    Spacer()
                    Image(systemName: "tray").resizable().scaledToFit().frame(height: 60)
                    HStack {
                        Spacer()
                        Text("No Todos")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                        Spacer()
                    }
                    Spacer()
                    Spacer()
                }.opacity(0.6)
            }
        }.animation(Animation.spring().speed(2))
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList().environmentObject(DataStore())
    }
}

extension AnyTransition {
    static let cell = asymmetric(
        insertion: .move(edge: .bottom),
        removal: AnyTransition.scale(scale: 0.8).combined(with: .opacity)
    )
}
