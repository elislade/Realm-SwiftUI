import SwiftUI

struct TodoCell: View {
    
    @EnvironmentObject var data:DataStore
    @Binding var todo:Todo
    
    @State private var showSettings = false
    @State private var showDatePicker = false
    
    func delete(){
        data.todoDB.delete(todo)
    }
    
    func remind(){
        showDatePicker.toggle()
        todo.realmMap().dateReminder = Date()
    }
    
    var reminderTxt:String {
        if let r = todo.dateReminder {
            return DateFormatter.localizedString(from: r, dateStyle: .long, timeStyle: .short)
        } else {
            return "No Reminder"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField("Title", text: $todo.content).padding()
                Spacer()
                if todo.content.count > 0 {
                    Button(action: { self.showSettings.toggle() }){
                        Image(systemName: "ellipsis.circle\(showSettings ? ".fill" : "")")
                            .imageScale(.large)
                    }.padding()
                }
            }
            
            if showSettings && todo.content.count > 0 {
                Divider()
                Button(action: delete){
                    HStack(spacing: 12) {
                        Image(systemName: "trash")
                        Text("Delete")
                        Spacer()
                    }.padding().foregroundColor(.red)
                }
                Divider()
                Button(action: remind){
                    HStack(spacing: 12) {
                        Image(systemName: "bell")
                        Text("Remind")
                        Spacer()
                        Text(reminderTxt).foregroundColor(.primary)
                    }.padding()
                }
                
                if showDatePicker {
                    DatePicker(date: $todo.dateReminder)
                }
            }
        }.font(.system(size: 18, weight: .bold, design: .rounded))
    }
}

struct TodoCell_Previews: PreviewProvider {
    static var previews: some View {
        TodoCell(todo: .constant(Todo())).environmentObject(DataStore())
    }
}
