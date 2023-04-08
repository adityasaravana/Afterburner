// MODIFIED CODE
import SwiftUI
struct ContentView: View {
    @State private var textFieldString = ""
    var body: some View {
        VStack {
            // Create a TextField and store the text in an @State variable
            TextField("Enter your text here", text: $textFieldString)
            Text("Hello, World!")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
