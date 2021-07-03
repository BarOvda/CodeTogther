//
//  profile-view.swift
//  CodeTogether
//
//  Created by user on 01/07/2021.
//

import SwiftUI

struct MyProfileView: View {
    
    @Binding var appState: AppStartUpState
    
    var body: some View {
        VStack{
            HStack{
                
                Spacer()
                Button {
                    appState = .Login
                } label: {
                    Image("logout")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .opacity(1)
                        .foregroundColor(Color.blue)
                }
                
                
                
            }.padding()
            GeometryReader{ geo in
                ScrollView{
                    VStack{
                        MyProfileHeader()
                        
                        MyAboutView()
                            .padding(.top)
                        
                        MySkillsView()
                            .padding(.top)
                        
                        MyMapView()
                            .padding(.top)
                        
                        MyContactInformationView()
                            .padding(.top)
                    }.padding()
                }
            } .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

struct MyAboutView: View {
    
    var desc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    
    var body: some View{
        
        VStack(alignment: .leading){
            HStack{
            Text("About")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .lineLimit(1)
                Spacer()
                Image("add")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.blue)
                    .cornerRadius(20)
            }
            
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text(desc)
                .font(.system(size: 12))
                .foregroundColor(Color.black)
            

        }
    }
}

struct MyMapView: View {
    
    var body: some View{
        VStack(alignment: .leading){
            
            HStack{
                Text("Location")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                Spacer()
                Image("add")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.blue)
                    .cornerRadius(20)
                
            }
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.top)
            
            Rectangle()
                .frame(height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            
            
        }
    }
}

struct MyContactInformationView: View {
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
            Text("Contact Information")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .lineLimit(1)
                Spacer()
                Image("add")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.blue)
                    .cornerRadius(20)
            }
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            HStack(spacing: 20){
                Text("Email")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
                Spacer()
                
                Text("johndoe@gmail.com")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
            }.padding(.top)
            
            HStack(spacing: 20){
                Text("Phone")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
                Spacer()
                
                Text("00000000")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
            }.padding(.top)
            
            
            
            
        }
    }
}

struct MySkillsView: View {
    
    var desc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    
    var body: some View{
        
        VStack(alignment: .leading){
            HStack{
            Text("Skills")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .lineLimit(1)
                Spacer()
                Image("add")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.blue)
                    .cornerRadius(20)
            
            }
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            
                HStack(spacing: 10){
                    SkillView()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    SkillView()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    SkillView()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    SkillView()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                        )
              
            }

        }
    }
}

struct MyCustomDivider: View {
   
    var body: some View{
        GeometryReader{ geo in
            HStack(spacing: 0){
                Rectangle()
                   
                    .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.black)
                Rectangle()
                    
                    .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.blue)
            }
        }
    }
}

struct MyProfileHeader: View{
    var body: some View{
        HStack{
            
            Text("Carlos Hooper")
                .bold()
                .font(.system(size: 20))
                .foregroundColor(Color.black)
                .lineLimit(1)
            
            Spacer()
            
            Image("placeholder")
                .resizable()
                .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(20)
            
        }
    }
}
