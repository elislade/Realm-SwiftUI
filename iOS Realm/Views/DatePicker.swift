import SwiftUI

struct DatePicker: View {
    @Binding var date:Date?
    
    func setDate(_ sec:TimeInterval){
        let n = Date()
        date = n.advanced(by: sec)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 12) {
                Button(action:{ self.setDate(60) }){
                    Text("One Minute")
                        .padding(.horizontal).padding(.vertical, 10)
                        .background(Color.blue).cornerRadius(8)
                }
                Button(action:{ self.setDate(60 * 60) }){
                    Text("One Hour")
                        .padding(.horizontal).padding(.vertical, 10)
                        .background(Color.blue).cornerRadius(8)
                }
                Button(action:{ self.setDate(60 * 60 * 24) }){
                    Text("One Day")
                        .padding(.horizontal).padding(.vertical, 10)
                        .background(Color.blue).cornerRadius(8)
                }
                Button(action:{ self.setDate(60 * 60 * 24 * 7) }){
                    Text("One Week")
                        .padding(.horizontal).padding(.vertical, 10)
                        .background(Color.blue).cornerRadius(8)
                }
            }.foregroundColor(.white).padding([.horizontal, .bottom])
        }
    }
}

struct DatePicker_Previews: PreviewProvider {
    static var previews: some View {
        DatePicker(date:.constant(Date()))
    }
}
