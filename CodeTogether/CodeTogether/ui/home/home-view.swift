//
//  home-view.swift
//  CodeTogether
//
//  Created by user on 30/06/2021.
//

import SwiftUI
import Firebase
struct HomeView: View {
    
    @Binding var currentTab: HomeTabs
    @State var text = ""
    @State private var isPresented = false
    @State var showAddProjectView: Bool = false
    @State var projects: [Project] = []
    @State var allProjects: [Project] = []
    @State var isLoading: Bool = false
    
    var body: some View {
       
            ZStack(alignment: .center){
                GeometryReader{ geo in
                    
                VStack{
                    NewProjectsHeader(showAddProjectView: $showAddProjectView)
                        .padding()
                    
                    SearchBar(text: $text)
                    
                    VStack{
                            
                        ScrollView(showsIndicators: false){
                            
                            VStack{
                              
                                ForEach(projects){ project in
                                    
                                    ProjectItemView(currentTab: $currentTab, project: project)
                                    
                                }
                        }
                            
                    }
                    
                    } .navigationBarTitle("Home", displayMode: .inline)
                    .navigationBarHidden(true)
                    .onChange(of: text){ data in
                        if text.count == 0{
                            projects.removeAll()
                            for project in allProjects{
                                projects.append(project)
                            }
                        }else{
                            let projectsList = allProjects.filter { ($0.name?.lowercased().starts(with: text.lowercased()))! }
                            projects = projectsList
                        }
                    }
                    .onAppear{
                        isLoading = true
                        projects.removeAll()
                        
                        let docRef = Firestore.firestore()
                            .collection("project_proposal")
                            
                        
                        docRef.getDocuments() { (querySnapshot, err) in
                            isLoading = false
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                for document in querySnapshot!.documents {
                                    print("\(document.documentID) => \(document.data())")
                                    let data = document.data()
                                    if data != nil{
                                        var project = Project()
                                        project.name = data["name"] as? String
                                        project.description = data["description"] as? String
                                        project.skills = data["skills"] as? [String]
                                        project.no_of_developers = data["no_of_developers"] as? String
                                        project.user_id = data["user_id"] as? String
                                        project.project_id = document.documentID
                                        projects.append(project)
                                        allProjects.append(project)
                                    }
                                }
                            }
                        }
                    }

                }.frame(width: geo.size.width, height: geo.size.height)
                
                
                
            }
                if isLoading{
                    
                    ProgressView()
                    
                }else{
                    
                    if !isLoading && projects.count == 0{
                        Text("Nothing to Show")
                    }
                    
                }
        }
        
    }
}

struct NewProjectsHeader: View {
    
    @Binding var showAddProjectView: Bool
    
    var body: some View{
        ZStack{
            NavigationLink("", destination: AddProjectView(showAddProjectView: $showAddProjectView), isActive: $showAddProjectView)
            HStack{
                Image(systemName: "plus")
                    .frame(width: 40, height: 40)
                    .opacity(0)
                    .onTapGesture {
                        showAddProjectView = true
                    }
                Spacer()
                Text("Home")
                    .bold()
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                Spacer()
                Button {
                    showAddProjectView = true
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .opacity(1)
                        .foregroundColor(Color.blue)
                }
            
            }
        }
    }
    
}
