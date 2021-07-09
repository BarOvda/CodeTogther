import SwiftUI

struct EditContactInfoAlert: View {
    @Environment(\.presentationMode) var presentationMode

    /// Edited value, passed from outside
    @Binding var value: [String]?

    
    /// Prompt message
    var prompt: String = ""
    
    /// The value currently edited
    @State var fieldValue: [String]? = []
    @State var skill: String = ""
    
    /// Init the Dialog view
    /// Passed @binding value is duplicated to @state value while editing
    
    var body: some View {
        VStack() {
            
            Text("Skill")
                .bold()
                .padding(.top, 50)
                .foregroundColor(Color.blue)
            
            HStack{
            TextField("Add a new Skill", text: $skill)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                Button("Add") {
                    if skill.count > 0{
                        fieldValue!.append(skill)
                        skill = ""
                    }
                }.foregroundColor(.blue)
            }
            
            Divider()
                .padding(.top)
            
            ForEach(fieldValue!, id: \.self) { data in
                HStack{
                    Text(data)
                    Spacer()
                    Image("delete")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.blue)
                        .cornerRadius(20)
                        .onTapGesture {
                            if let index = fieldValue!.firstIndex(of: data) {
                                fieldValue!.remove(at: index)
                            }
                        }
                }
            }
            
           
            Spacer()
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
