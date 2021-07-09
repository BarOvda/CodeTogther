//
//  profile-view.swift
//  CodeTogether
//
//  Created by user on 30/06/2021.
//

import SwiftUI
import Firebase

struct ProjectItemView: View {
    
    @Binding var currentTab: HomeTabs
    @State var user: User = User()
    @State var project: Project
    @State var isProfileActive = false
    
    var body: some View {
       
            VStack{
                GeometryReader { geo in
                    VStack{
                HStack(spacing: 5){
                    HStack{
                        
                        NavigationLink("", destination: ProfileView(userId: project.user_id ?? ""), isActive: $isProfileActive)
                       
                            ImageDownloader(height:40, width:40,imageURL: user.pic ?? "", isCircleShape: true, placeHolder: { PlaceHolderView(circleShape: true) })
                                .id(UUID())
                                .cornerRadius(20)
                                .onTapGesture {
                                    if project.user_id == Auth.auth().currentUser?.uid{
                                        currentTab = .ProfileTab
                                    }else{
                                        isProfileActive = true
                                    }
                                }
                        
                        Text(user.username ?? "")
                            .bold()
                            .foregroundColor(Color.black)
                            .padding(.leading)
                            .lineLimit(1)
                        Spacer()
                        
                    }.frame(width: geo.size.width * 0.55)
                  
                    HStack{
                        Spacer()
                        Text(project.name ?? "")
                            .bold()
                            .foregroundColor(Color.black)
                            .padding(.leading)
                            .lineLimit(1)
                        
                        Spacer()
                        
                    }.frame(width: geo.size.width * 0.35)
                }
                Divider()
                HStack(spacing: 0){
                    VStack{
                        
                        Text("Stack")
                            .bold()
                            .foregroundColor(Color.black)
                            .padding(.leading)
                            .lineLimit(1)
                        
                        StackView(project: $project)
                            .frame(width: geo.size.width * 0.55)
                            .frame(minHeight: 80, maxHeight: .infinity)
                        
                        Spacer()
                        
                    }
                    .frame(minHeight: 80, maxHeight: .infinity)
                    VStack{
                        
                        Text("Description")
                          
                            .bold()
                            .foregroundColor(Color.black)
                            .lineLimit(1)
                        
                        ZStack{
                            VStack{
                            Text(project.description ?? "")
                                .font(.system(size: 12))
                                .foregroundColor(Color.black)
                                .padding(5)
                                .frame(width: geo.size.width * 0.35, alignment: .topLeading)
                               
                                Spacer()
                            }.frame(minHeight: 80, maxHeight: .infinity)
                            
                        } .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        
                        Spacer()
                        
                    }.frame(width: geo.size.width * 0.35)
                   
                    
                }
                
                HStack{
                    
                    Text("No Of Developers = \(project.no_of_developers ?? "0")")
                        .foregroundColor(Color.black)
                        .padding(.leading)
                        .lineLimit(1)
                    
                    
                }
               
                CustomDivider()
                    .frame( height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.padding()
            .onAppear{
                getUser()
            }
                }
        } .frame(minHeight: 250, maxHeight: .infinity)
    }
    
    private func getUser() {
        //Get specific document from current user
        guard let userId = project.user_id else{
            return
        }
        let docRef = Firestore.firestore()
            .collection("user")
            .document(userId)
        
        // Get data
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else {
                print("Document does not exist")
                return
            }
            if let data = document.data(){
                var user = User()
                user.username = data["name"] as? String
                user.email = data["email"] as? String
                user.pic = data["pic"] as? String
                user.phone = data["phone"] as? String
                user.about = data["about"] as? String
                user.skills = data["skills"] as? [String]
                user.lat = data["lat"] as? Double
                user.lng = data["lng"] as? Double
                self.user = user
            }
        }
    }
    
}

struct StackView: View {
    @State var displayEditSheet: Bool = false
    @Binding var project: Project
    
    @State var skills: [String]? = []
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View{
        //        GeometryReader{ geo in
        VStack(alignment: .leading){
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(project.skills ?? [], id: \.self){ skill in
                    SkillView(skill: skill)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }
            
            Spacer()
            
        }
    }
    
}
