//
//  login-view.swift
//  CodeTogether
//
//  Created by user on 30/06/2021.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var appState: AppStartUpState
    
    @State var Username: String = ""
    @State var Password: String = ""
    
    @State var IsLoading: Bool = false
    @State var showAlert = false
    @State var alertMessage: String = ""
    
    var body: some View {
        GeometryReader { geo in
            ScrollView{
                VStack(alignment: .leading)
                {
                    
                    CircularLogoView()
                    
                    HStack {
                        Text("Sign In")
                            .bold()
                            .font(.system(size: 25))
                            .foregroundColor(Color.black)
                    }
                    VStack(alignment: .leading){
                        Text("Hi there nice to see you again")
                            .bold()
                            .padding(.top)
                            .foregroundColor(Color.gray)
                        
                        Text("Email")
                            .bold()
                            .padding(.top, 50)
                            .foregroundColor(Color.blue)
                        
                        
                        TextField("Email", text: $Username)
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
                        HStack{
                            Spacer()
                            Text("Forget Password?")
                                .bold()
                                .padding(.top)
                                .foregroundColor(Color.blue)
                        }.padding(.bottom)
                    }
                    
                   
                        Text("Login")
                            .frame(width: geo.size.width, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .onTapGesture
                            {
                                appState = .Home
                            }
                  
                      
                    
                    
                    HStack{
                        Spacer()
                        Text("Don't have an account?")
                            .bold()
                            .padding(.top)
                            .foregroundColor(Color.gray)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        
                            Text("SignUp")
                                .bold()
                                .padding(.top)
                                .foregroundColor(Color.blue)
                                .onTapGesture{
                                    appState = .SignUp
                                }
                      
                       
                        Spacer()
                    }
                    
                }
            }
        }.padding(20)
    }
    
    func login(){
        
    }
}
