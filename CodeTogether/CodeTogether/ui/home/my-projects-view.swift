//
//  my-projects-view.swift
//  CodeTogether
//
//  Created by user on 30/06/2021.
//

import SwiftUI
import Firebase

struct MyProjectsView: View {
    
    @State var isLoading: Bool = false
    @Binding var currentTab: HomeTabs
    @State var text = ""
    @State var projects: [Project] = []
    
    var body: some View {
        
        VStack{
            
            ZStack(alignment: .center){
                
                VStack{
                    
                    ScrollView(showsIndicators: false){
                        
                        VStack{
                            
                            ForEach(projects){ project in
                                
                                ProjectItemView(currentTab: $currentTab, project: project)
                                
                            }
                        }
                        
                    }
                   
                }
                
                if isLoading{
                    
                    ProgressView()
                    
                }else{
                    
                    if !isLoading && projects.count == 0{
                        Text("Nothing to Show")
                    }
                    
                }
            }
            
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .onAppear{
                
                isLoading = true
                
                projects.removeAll()
                
                let docRef = Firestore.firestore()
                    .collection("project_proposal")
                
                guard let id = Auth.auth().currentUser?.uid else{
                    isLoading = false
                    return
                }
                
                
                docRef.whereField("user_id", isEqualTo: id).getDocuments() { (querySnapshot, err) in
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
                            }
                        }
                    }
                }
            }
        }
    }
}
