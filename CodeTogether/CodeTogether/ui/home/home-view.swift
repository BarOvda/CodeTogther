//
//  home-view.swift
//  CodeTogether
//
//  Created by user on 30/06/2021.
//

import SwiftUI

struct HomeView: View {
    
    @State var text = ""
    @State private var isPresented = false
    @State var showAddProjectView: Bool = false
    
    var body: some View {
        GeometryReader{ geo in
               
                VStack{
                    NewProjectsHeader(showAddProjectView: $showAddProjectView)
                        .padding(.bottom)
                    SearchBar(text: $text)
                    
                    ScrollView{
                        LazyVStack{
                            
                            ProjectItemView()
                                .frame(height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            CustomDivider()
                                .frame( height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            ProjectItemView()
                                .frame(height: 250, alignment: .center)
                            CustomDivider()
                                .frame( height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            ProjectItemView()
                                .frame(height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            CustomDivider()
                                .frame( height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            ProjectItemView()
                                .frame(height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            CustomDivider()
                                .frame( height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                    }
                    Spacer()
                }.navigationTitle("Home")
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                .padding()
            
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
                Text("John Doe")
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

struct home_view_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
