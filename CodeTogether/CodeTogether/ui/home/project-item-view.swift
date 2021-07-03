//
//  profile-view.swift
//  CodeTogether
//
//  Created by user on 30/06/2021.
//

import SwiftUI

struct ProjectItemView: View {
    
    var desc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                HStack(spacing: 5){
                    HStack{
                       
                        NavigationLink(
                            destination: ProfileView()){
                        
                        Image("placeholder")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(20)
                        
                        }
                        
                        Text("John Doe")
                            .bold()
                            .foregroundColor(Color.black)
                            .padding(.leading)
                            .lineLimit(1)
                        Spacer()
                        
                    }.frame(width: geo.size.width * 0.55)
                    HStack{
                        Spacer()
                        Text("Cards Game")
                            .bold()
                            .foregroundColor(Color.black)
                            .padding(.leading)
                            .lineLimit(1)
                        
                        Spacer()
                        
                    }.frame(width: geo.size.width * 0.35)
                }
                
                HStack(spacing: 0){
                    VStack{
                        StackView()
                            .frame(width: geo.size.width * 0.55, height: 120)
                        HStack{
                            
                            Text("No Of Developers = 1")
                               
                                .foregroundColor(Color.black)
                                .padding(.leading)
                                .lineLimit(1)
                            Spacer()
                        }
                        Spacer()
                    }
                    VStack{
                        Text("Description")
                            .bold()
                            .foregroundColor(Color.black)
                            .padding(.leading)
                            .lineLimit(1)
                        ZStack{
                        Text(desc)
                            .font(.system(size: 12))
                            .foregroundColor(Color.black)
                            .padding(5)
                            .frame(width: geo.size.width * 0.35, height: 80, alignment: .topLeading)
                           
                        } .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        Spacer()
                    }.frame(width: geo.size.width * 0.35)
                    
                }
                
                Divider()
            }.padding()
            .frame(height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
        }
    }
}

struct profile_view_Previews: PreviewProvider {
    static var previews: some View {
        ProjectItemView()
    }
}


struct StackView: View {
  
    var body: some View{
        GeometryReader{
            geo in
            VStack{
                HStack{
                    Spacer()
                    
                    Text("Stack")
                        .bold()
                        .foregroundColor(Color.black)
                        .padding(.leading)
                        .lineLimit(1)
                        .frame(width: geo.size.width  * 0.4)
                    Spacer()
                }
                
                ScrollView{
                    LazyHStack(spacing: 10){
                        SkillView()
                            .frame(width: geo.size.width * 0.44)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        SkillView()
                            .frame(width: geo.size.width * 0.44)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                }
                
            }
        }
        
    }
}
