//
//  profile-view.swift
//  CodeTogether
//
//  Created by user on 01/07/2021.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                VStack{
                    ProfileHeader()
                    
                    AboutView()
                        .padding(.top)
                    
                    SkillsView()
                        .padding(.top)
                    
                    MapView()
                        .padding(.top)
                    
                    ContactInformationView()
                        .padding(.top)
                }.padding()
            }
        } .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(false)
    }
}

struct AboutView: View {
    
    var desc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    
    var body: some View{
        
        VStack(alignment: .leading){
            Text("About")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .lineLimit(1)
            
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text(desc)
                .font(.system(size: 12))
                .foregroundColor(Color.black)
            

        }
    }
}

struct MapView: View {
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Location")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .lineLimit(1)
           
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.top)
            
            Rectangle()
                .frame(height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            
            
        }
    }
}

struct ContactInformationView: View {
    
    var body: some View{
        VStack(alignment: .leading){
            
            Text("Contact Information")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .lineLimit(1)
           
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

struct SkillsView: View {
    
    var desc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    
    var body: some View{
        
        VStack(alignment: .leading){
            Text("Skills")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .lineLimit(1)
            
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

struct CustomDivider: View {
   
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

struct ProfileHeader: View{
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

struct profilea_view_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
