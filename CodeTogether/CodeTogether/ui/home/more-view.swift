//
//  more-view.swift
//  CodeTogether
//
//  Created by user on 01/07/2021.
//

import SwiftUI

struct MoreRow: Identifiable
{
    let id = UUID()
    let title: String
    let icon: String
    let target: AnyView
    let isGuardian : Bool = true
}

struct MoreList
{
    static let list : [MoreRow] =
        [
            MoreRow(title: "Profile", icon: "Profile", target: AnyView(ProfileView())),
            MoreRow(title: "Logout", icon: "MissingIcon", target: AnyView(Text("Logout destination"))),
        ]
}

struct MoreTab: View {
    
    var logoutFunc: () -> ()
    var body: some View {
        VStack
        {
            NavigationLink(destination : MyProfileView()){
                VStack
                {
                    Image("placeholder")
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                        .cornerRadius(60)
                    
                    Text("John Doe")
                        .bold()
                    Text("john@gmail.com")
                        .foregroundColor(.black)
                }
                .foregroundColor(Color.blue)
            }
            .padding(.horizontal)
            
          
            NavigationLink(destination : MyProfileView())
            {
                HStack
                {
                    Image(systemName: "person.fill")
                    Text("Edit Profile")
                        .padding()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(.horizontal, 8)
                }.foregroundColor(Color.blue)

            }
            
            Divider()
            HStack
            {
               
                Image(systemName: "person.fill")
                    .opacity(0.0)
                Text("Logout")
                    .padding()
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.horizontal, 8)
            }.foregroundColor(Color.blue)
          
            Divider()
            
            Spacer()
        }.padding()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        
    }
}

//struct more_tab_Previews: PreviewProvider {
//    static var previews: some View {
//        MoreTab()
//    }
//}
