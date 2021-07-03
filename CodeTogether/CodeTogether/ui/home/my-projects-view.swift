//
//  my-projects-view.swift
//  CodeTogether
//
//  Created by user on 30/06/2021.
//

import SwiftUI

struct MyProjectsView: View {
    
    @State var text = ""
    
    var body: some View {
        
        VStack{
                
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
        .padding()
        } .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct my_project_view_Previews: PreviewProvider {
    static var previews: some View {
        MyProjectsView()
    }
}
