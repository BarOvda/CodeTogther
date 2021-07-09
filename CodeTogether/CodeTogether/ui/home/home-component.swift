
import SwiftUI

enum HomeTabs: Int, Hashable
{
    case HomeTab = 0
    case MyProjectsTab = 1
    case ProfileTab = 2
    case MoreTab = 3
}

struct HomeComponent: View {
    @State var currentTab: HomeTabs = .HomeTab
    @Binding var appState: AppStartUpState
    var body: some View {
        NavigationView{
            ZStack{
            GeometryReader
            {
                reader in
                
                ZStack{
                    
                    TabView(selection: $currentTab){
                        
                        HomeView(currentTab: $currentTab)
                            .tabItem {
                                
                                Image(systemName: "bag.fill")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                                Text("Home")
                            }
                            .tag(HomeTabs.HomeTab)
                        
                        MyProjectsView(currentTab: $currentTab)
                            .tabItem {
                                
                                Image(systemName: "bag.fill.badge.plus")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 40, height: 40, alignment: .center)
                                Text("My Projects")
                            }   .tag(HomeTabs.MyProjectsTab)
                        
                        
                        
                        MyProfileView(appState: $appState)
                            .tabItem {
                                Image(systemName: "person.fill")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 40, height: 40, alignment: .center)
                                Text("Profile")
                            }
                            .tag(HomeTabs.ProfileTab)
                        
                        EmptyView()
                        .tabItem {
                            Image("More")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                            Text("Logout")
                                .onTapGesture {
                                    
                                }
                        }
                        .tag(HomeTabs.MoreTab)
                    }.accentColor(Color.blue)
                }
            }
        }
        }
       
    }
}
