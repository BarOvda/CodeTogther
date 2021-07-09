

import SwiftUI
import Firebase

struct ProfileView: View {
    
    @State var user: User = User()
    var userId: String
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView(showsIndicators: false){
                VStack{
                    ProfileHeader(user: $user)
                    
                    AboutView(user: $user)
                        .padding(.top)
                    
                    SkillsView(user: $user)
                        .padding(.top)
                    
                    MapView(user: $user)
                        .padding(.top)
                    
                    ContactInformationView(user: $user)
                        .padding(.top)
                }.padding()
            }
        } .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(false)
        .onAppear{
            getDocument()
        }
    }
    
    
    private func getDocument() {
        //Get specific document from current user
        
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

struct AboutView: View {
    
    @Binding var user: User
    
    var body: some View{
        
        VStack(alignment: .leading){
            Text("About")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .lineLimit(1)
            
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text(user.about ?? "")
                .font(.system(size: 12))
                .foregroundColor(Color.black)
            

        }
    }
}

import MapKit

struct MapView: View {
    @Binding var user: User
    @State private var annoations: [Location] = []
    @State private var region: MKCoordinateRegion =  MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 31.0,
            longitude: 34.8
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 10,
            longitudeDelta: 10
        )
    )
    
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Location")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .lineLimit(1)
           
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.top)
            
            Map(coordinateRegion: $region, annotationItems: annoations) { loc in

                MapMarker(coordinate: loc.coordinate, tint: .red)
            }
                .frame(height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .onChange(of: user.lng, perform: { value in
                if user != nil{
                   
                    var location =  Location(coordinate: .init(latitude: (user.lat)!, longitude: (user.lng)!))
                    
                    annoations.append(location)
                    
                    region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: (user.lat)!,
                            longitude: (user.lng)!
                        ),
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.05,
                            longitudeDelta: 0.05
                        )
                    )
                }
            }).onAppear{
                if user.lng != 0.0{
                   
                    var location =  Location(coordinate: .init(latitude: (user.lat)!, longitude: (user.lng)!))
                    
                    annoations.append(location)
                    
                    region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: (user.lat)!,
                            longitude: (user.lng)!
                        ),
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.05,
                            longitudeDelta: 0.05
                        )
                    )
                }
            }
        
                
            
            
        }
    }
}

struct ContactInformationView: View {
    
    @Binding var user: User
    
    var body: some View{
        VStack(alignment: .leading){
            
            Text("Contact Information")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .lineLimit(1)
           
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            HStack(spacing: 20){
                Text("Email")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
                Spacer()
                
                Text(user.email ?? "")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
            }.padding(.top)
            
            HStack(spacing: 20){
                Text("Phone")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
                Spacer()
                
                Text(user.phone ?? "")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
            }.padding(.top)
            
            
            
            
        }
    }
}

struct SkillsView: View {
    
    @Binding var user: User
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View{

        VStack(alignment: .leading){
            HStack{
                Text("Skills")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                Spacer()
               
            }
            
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            
           
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(user.skills ?? [], id: \.self){ skill in
                    SkillView(skill: skill)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }
            
            
        }
    }
}

struct CustomDivider: View {
   
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

struct ProfileHeader: View{
    
    @Binding var user: User
    
    var body: some View{
        HStack{
            
            Text(user.username ?? "")
                .bold()
                .font(.system(size: 20))
                .foregroundColor(Color.black)
                .lineLimit(1)
            
            Spacer()
            
            ImageDownloader(height:40, width:40,imageURL: user.pic ?? "", isCircleShape: true, placeHolder: { PlaceHolderView(circleShape: true) })
                .id(UUID())
                .cornerRadius(20)
            
            
        }
    }
}
