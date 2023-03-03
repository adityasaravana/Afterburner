/// ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
// Swift 5
struct ContentView: View {
    @State private var text = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            TextEditor(text: $text)
        }
        .padding()
    }
}
