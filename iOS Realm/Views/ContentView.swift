import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data:DataStore

    func addItem(){
        data.todoDB.create(Todo())
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Todos").font(.system(size: 38, weight: .heavy, design: .default))
                Spacer()
            }.padding().overlay(Divider(), alignment: .bottom)
            
            TodoList().overlay(Button(action:addItem){
                Image(systemName: "plus")
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .frame(width: 60, height: 60)
                    .background(Image("RealmSunset").resizable())
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .shadow(radius: 10, y: 10)
                }.padding(18), alignment: .bottomTrailing)
        }.edgesIgnoringSafeArea([.bottom, .horizontal])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataStore())
    }
}
