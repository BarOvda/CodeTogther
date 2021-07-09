import SwiftUI

struct CustomMultilineTextFieldAlert: View {
    @Environment(\.presentationMode) var presentationMode

    /// Edited value, passed from outside
    @Binding var value: String?
    
    /// Prompt message
    var prompt: String = ""
    
    /// The value currently edited
    @State var fieldValue: String
    
    /// Init the Dialog view
    /// Passed @binding value is duplicated to @state value while editing
    init(prompt: String, value: Binding<String?>) {
        _value = value
        self.prompt = prompt
        _fieldValue = State<String>(initialValue: value.wrappedValue ?? "")
    }

    var body: some View {
        VStack() {
            Text(prompt)
                .padding()
            TextEditor(text: $fieldValue)
                .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            HStack {
            Button("Done") {
                self.value = fieldValue
                self.presentationMode.wrappedValue.dismiss()
            }
                Spacer()
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
            }.padding()
        }
        .padding()
    }
}
