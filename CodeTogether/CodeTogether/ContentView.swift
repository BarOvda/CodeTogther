
import SwiftUI
import Firebase

enum AppStartUpState
{
    case SignUp
    case Login
    case Home
}


struct ContentView: View {
   
    @State var appState: AppStartUpState = .Login
    
    
    var body: some View {
        HStack{
            
        }.onAppear{
            
            if Auth.auth().currentUser == nil{
                appState = .Login
            }else{
                appState = .Home
            }
            
        }
        
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
