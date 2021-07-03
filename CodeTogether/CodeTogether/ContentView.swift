//
//  ContentView.swift
//  CodeTogether
//
//  Created by user on 30/06/2021.
//

import SwiftUI

enum AppStartUpState
{
    case SignUp
    case Login
    case Home
}

struct ContentView: View {
    
    @State var appState: AppStartUpState = .Login
    
    
    var body: some View {
        if appState == .Login{
            LoginView(appState: $appState)
        }
        if appState == .SignUp{
            SignUp(appState: $appState)
        }

        if appState == .Home{
            HomeComponent(appState: $appState)
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
