//
//  AddProjectView.swift
//  CodeTogether
//
//  Created by user on 01/07/2021.
//

import SwiftUI

struct AddProjectView: View {
    
    @Binding var showAddProjectView: Bool
   
    
    var body: some View {
        VStack{
//            GeometryReader{ geo in
                ScrollView{
                    VStack{
                        AddProjectProfileHeader()
                        
                        AddProjectAboutView()
                            .padding(.top)
                        
                        AddProjectSkillsView()
                            .padding(.top)
                        
                        AddProjectMapView()
                            .padding(.top)
                        
                        AddProjectContactInformationView()
                            .padding(.top)
                        
                        Button {
                            showAddProjectView = true
                        } label: {
                            
                            Text("Add")
                                .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                        }.padding(.top, 20)
                        
                        
                    }.padding()
                }
            } .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(false)
//        }
    }
}

struct AddProjectAboutView: View {
    
    var desc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    
    var body: some View{
        
        VStack(alignment: .leading){
            HStack{
                Text("Description")
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

struct AddProjectMapView: View {
    
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

struct AddProjectContactInformationView: View {
    @State var noOfDevelopers = ""
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("No of Developers")
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
            
            VStack(alignment: .leading){
                
                Text("Developers Required")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
                CustomDivider()
                    .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                TextField("No of Developers", text: $noOfDevelopers)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.top)
                
            }.padding(.top)
            
        }
    }
}

struct AddProjectSkillsView: View {
    
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
        .navigationTitle("")
        .navigationBarHidden(false)
    }
}

struct AddProjectCustomDivider: View {
    
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

struct AddProjectProfileHeader: View{
    @State var name: String = ""
    
    var body: some View{
        VStack(alignment: .leading){
            
            Text("Project Name")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .lineLimit(1)
            
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            TextField("Project Name", text: $name)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top)
            
        }
    }
}
