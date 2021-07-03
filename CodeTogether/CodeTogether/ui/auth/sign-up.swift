//
//  sign-up.swift
//  CodeTogether
//
//  Created by user on 30/06/2021.
//

import SwiftUI

struct SignUp: View {
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
                    
                    HStack {
                        Text("Sign Up")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.system(size: 25))
                    }.padding(.top, 20)
                    VStack(alignment: .leading){
                       
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
                    }
                    
                   
                            Text("Continue")
                                .frame(width: geo.size.width, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.top, 100)
                                .onTapGesture {
                                    appState = .SignUp
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
    }
    
    func login(){
        
    }
}
