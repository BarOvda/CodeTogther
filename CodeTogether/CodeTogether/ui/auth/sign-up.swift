//
//  sign-up.swift
//  CodeTogether
//
//  Created by user on 30/06/2021.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SignUp: View {
    @Binding var appState: AppStartUpState
    @State var Username: String = ""
    @State var Password: String = ""
    @State var email: String = ""
    @State var IsLoading: Bool = false
    @State var showAlert = false
    @State var alertMessage: String = ""
    @State var showToast: Bool = false
    @State var toastMsg: String = ""
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading)
                {
                    
                    HStack {
                        Text("Sign Up")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.system(size: 25))
                    }.padding(.top, 20)
                    VStack(alignment: .leading){
                        
                        Text("Username")
                            .bold()
                            .padding(.top, 50)
                            .foregroundColor(Color.blue)
                        
                        
                        TextField("Username", text: $Username)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        Divider()
                            .padding(.top)
                        
                        
                        Text("Email")
                            .bold()
                            .padding(.top)
                            .foregroundColor(Color.blue)
                        
                        
                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        Divider()
                            .padding(.top)
                        
                        Text("Password")
                            .bold()
                            .padding(.top)
                            .foregroundColor(Color.blue)
                        
                        
                        SecureField("Password", text: $Password)
                        
                        Divider()
                            .padding(.top)
                    }
                    
                    
                    Text("Continue")
                        .frame(width: geo.size.width, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 100)
                        .onTapGesture {
                            signUp()
                        }
                    
                    
                    HStack{
                        Spacer()
                        Text("Have an account? ")
                            .bold()
                            .padding(.top)
                            .foregroundColor(Color.gray)
                        
                        Text("Sign In")
                            .bold()
                            .padding(.top)
                            .foregroundColor(Color.blue)
                            .onTapGesture {
                                appState = .Login
                            }
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        
                        Spacer()
                    }
                    
                }
            }
        }.padding(20)
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            
        })
        .toast(isPresenting: $showToast){
            AlertToast(type: .regular, title: toastMsg)
        }
        .toast(isPresenting: $IsLoading){
            AlertToast(type: .loading, title: "Loading", subTitle: "")
        }
    }
    
    func signUp(){
        
        if validate(){
            IsLoading = true
            Auth.auth().createUser(withEmail: self.email, password: self.Password) { authResult, error in
                IsLoading = false
                if let description =  error?.localizedDescription {
                    alertMessage = description
                    showAlert = true
                }else{
                    
                    let collection = Firestore.firestore().collection("user")
                    collection.document(authResult?.user.uid ?? "")
                        .setData(["email": email
                                  ,"name": Username]){
                            error in
                            toastMsg = "Successfully Sent"
                            showToast = true
                            
                            appState = .Home
                        }
                }
            }
            
        }else{
            showAlert = true
        }
    }
    
    func validate() -> Bool{
        let valid = true
        
        if Username.count == 0{
            alertMessage = "Username should not be empty"
            return false
        }
        
        if email.count == 0{
            alertMessage = "Email should not be empty"
            return false
        }
        
        if !email.contains("@"){
            alertMessage = "Invalid Email"
            return false
        }
        
        if Password.count == 0{
            alertMessage = "Password should not be empty"
            return false
        }
        
        if Password.count < 5{
            alertMessage = "Password is too short. It must be at least 6 characters long"
            return false
        }
        
        return valid
    }
}
