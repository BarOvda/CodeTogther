//
//  profile-view.swift
//  CodeTogether
//
//  Created by user on 01/07/2021.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct MyProfileView: View {
    
    @Binding var appState: AppStartUpState
    @State var user: User? = nil
    @State var isLoading: Bool = false
    @State var showAlert: Bool = false
    @State var msg: String = ""
    @State var toast: String = ""
    @State var showToast: Bool = false
    
    @StateObject var locationManager = LocationManager()
    
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    
    var body: some View {
        
        ZStack(alignment: .center){
            
            if !isLoading{
                
                VStack{
                    HStack{
                        
                        Spacer()
                        Button {
                            
                            do{
                                try Auth.auth().signOut()
                            }catch{
                                
                            }
                            appState = .Login
                            
                        } label: {
                            Image("logout")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 20, height: 20)
                                .opacity(1)
                                .foregroundColor(Color.blue)
                        }
                        
                        
                        
                    }.padding()
                    GeometryReader{ geo in
                        ScrollView(showsIndicators: false){
                            VStack{
                                MyProfileHeader(user: $user, isLoading: $isLoading)
                                
                                MyAboutView(user: $user)
                                    .padding(.top)
                                
                                MySkillsView(user: $user)
                                    .padding(.top)
                                
                                MyMapView(user: $user, showAlert: $showAlert, msg: $msg)
                                    .padding(.top)
                                
                                MyContactInformationView(user: $user)
                                    .padding(.top)
                                
                                Text("   Update   ")
                                    .frame(height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .padding(.top)
                                    .onTapGesture
                                    {
                                        if !isLoading{
                                            self.updateData()
                                        }
                                    }
                                
                                
                            }.padding()
                        }
                    } .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
                    .onAppear{
                        getDocument()
                    }
                }
                
                
            }else{
                ProgressView("Loading")
            }
        }.alert(isPresented: $showAlert, content: {
            Alert(title: Text("Alert"), message: Text(msg), dismissButton: .default(Text("OK")))
            
        }).toast(isPresenting: $showToast){
            AlertToast(type: .regular, title: toast)
        }
        
    }
    
    func validate() -> Bool{
        
        if user?.about?.count == 0{
            msg = "About field required."
            showAlert = true
            return false
        }
        
        if user?.skills?.count == 0{
            msg = "Please add atleast one skill."
            showAlert = true
            return false
        }
        
        if user?.lat == 0 || user?.lng == 0 || user?.lat == nil || user?.lng == nil{
            msg = "Please add location first"
            showAlert = true
            return false
        }
        
        if user?.phone?.count == 0 {
            msg = "Phone field Required"
            showAlert = true
            return false
        }
        
        return true
    }
    
    func updateData(){
        
        
        
        guard let userID = Auth.auth().currentUser?.uid else{
            return
        }
        
        if !validate(){
            return
        }
        
        isLoading = true
        
        let collection = Firestore.firestore().collection("user")
        collection.document(userID)
            .updateData(["email": user?.email ?? "",
                         "name": user?.username ?? "",
                         "skills": user?.skills,
                         "about": user?.about ?? "",
                         "phone": user?.phone ?? "",
                         "pic": user?.pic ?? "",
                         "lat": user?.lat ?? 0.0,
                         "lng": user?.lng ?? 0.0
            ]){
                error in
                isLoading = false
                toast = "Successfully Updated"
                showToast = true
                print("Updated")
            }
    }
    
    
    private func getDocument() {
        //Get specific document from current user
        guard let userId = Auth.auth().currentUser?.uid else{
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

struct MyAboutView: View {
    
    @Binding var user: User?
    
    @State var displayEditAbout: Bool = false
    @State var about: String? = ""
    
    
    var body: some View{
        
        VStack(alignment: .leading){
            HStack{
                Text("About")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                Spacer()
                Image("add")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.blue)
                    .cornerRadius(20)
                    .onTapGesture {
                        displayEditAbout = true
                    }
            }
            
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text(user?.about ?? "")
                .font(.system(size: 12))
                .foregroundColor(Color.black)
                .padding()
            
        }
        .sheet(isPresented: $displayEditAbout) {
            CustomMultilineTextFieldAlert(prompt: "Enter about", value: $about)
        }
        .onChange(of: about, perform: { value in
            if let value = about, about?.count ?? 0 > 0{
                user?.about = value
            }
        })
        
        
    }
    
    
}

import MapKit

struct Location: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MyMapView: View {
    
    @Binding var user: User?
    @Binding var showAlert: Bool
    @Binding var msg: String
    
    @StateObject var locationManager = LocationManager()
    
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var annoations: [Location] = []
    @State private var region: MKCoordinateRegion =  MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 31.7683,
            longitude: 35.2137
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )
    
    var body: some View{
        VStack(alignment: .leading){
            
            HStack{
                Text("Location")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                Spacer()
                
                Image("add")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.blue)
                    .cornerRadius(20)
                    .onTapGesture {
                        
                        if locationManager.locationManager.authorizationStatus == .denied{
                            msg = "Please enable location from settings first."
                            showAlert = true
                            
                            return
                        }
                        
                        let location =  Location(coordinate: .init(latitude: Double(userLatitude) ?? 31.7683, longitude: Double(userLongitude) ?? 35.2137))
                        
                        annoations.append(location)
                        
                        user?.lat = Double(userLatitude)
                        user?.lng = Double(userLongitude)
                        
                        region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: (user?.lat)!,
                                longitude: (user?.lng)!
                            ),
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.05,
                                longitudeDelta: 0.05
                            )
                        )
                    }
                
            }
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.top)
            
            Map(coordinateRegion: $region, annotationItems: annoations) { loc in
                //                    MapPin(coordinate: loc.coordinate, tint: .green)
                MapMarker(coordinate: loc.coordinate, tint: .red)
            }
            .frame(height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            
            
            
        }.onChange(of: (user != nil), perform: { value in
            
            if locationManager.locationManager.authorizationStatus == .denied{
                
                return
            }
            
            if user != nil{
                if user?.lat == nil || user?.lat == 0.0{
                    user?.lat = Double(userLatitude)
                    user?.lng = Double(userLongitude)
                }
                let location =  Location(coordinate: .init(latitude: Double(userLatitude) ?? 31.7683, longitude: Double(userLongitude) ?? 35.2137))
                
                annoations.append(location)
                
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: (user?.lat)!,
                        longitude: (user?.lng)!
                    ),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.05,
                        longitudeDelta: 0.05
                    )
                )
            }
        })
        
        .onAppear{
            
            if locationManager.locationManager.authorizationStatus == .denied{
                
                return
            }
            
            if user != nil{
                if user?.lat == nil || user?.lat == 0.0{
                    user?.lat = Double(userLatitude)
                    user?.lng = Double(userLongitude)
                }
                let location =  Location(coordinate: .init(latitude: (user?.lat)!, longitude: (user?.lng)!))
                
                annoations.append(location)
                
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: (user?.lat)!,
                        longitude: (user?.lng)!
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

struct MyContactInformationView: View {
    @State var changeContactInfo: Bool = false
    @State var phone: String? = ""
    @State var email: String? = ""
    @Binding var user: User?
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                
                Text("Contact Information")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
                Spacer()
                
                Image("add")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.blue)
                    .cornerRadius(20)
                    .onTapGesture {
                        dialog()
                    }
            }
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            HStack(spacing: 20){
                Text("Email")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
                Spacer()
                
                Text(user?.email ?? "")
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
                
                Text(user?.phone ?? "")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
            }.padding(.top)
            
            
            
            
        }
    }
    
    func dialog(){
        
        let alertController = UIAlertController(title: "Enter Phone", message: "Please enter your phone", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Phone"
            textField.keyboardType = .phonePad
        }
        
        let saveAction = UIAlertAction(title: "Done", style: .default, handler: { alert -> Void in
            
            let secondTextField = alertController.textFields![0] as UITextField
            
            user?.phone = secondTextField.text
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        
    }
}



struct MySkillsView: View {
    @State var displayEditSheet: Bool = false
    @Binding var user: User?
    
    @State var skills: [String]? = []
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View{
        //        GeometryReader{ geo in
        VStack(alignment: .leading){
            HStack{
                Text("Skills")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                Spacer()
                Image("add")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.blue)
                    .cornerRadius(20)
                    .onTapGesture {
                        displayEditSheet = true
                    }
                
            }
            
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(user?.skills ?? [], id: \.self){ skill in
                    SkillView(skill: skill)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }
            
            
        }.onAppear{
            if user?.skills == nil{
                user?.skills = []
            }
            if let skills = user?.skills{
                self.skills = skills
            }
        } .sheet(isPresented: $displayEditSheet) {
            EditContactInfoAlert(value: $skills, prompt: "Add Skill")
        }
        .onChange(of: skills, perform: { value in
            if let value = skills, skills?.count ?? 0 > 0{
                user?.skills = skills
            }
        })
        //        }
    }
    
    
}

struct MyCustomDivider: View {
    
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

struct MyProfileHeader: View{
    @State var showingImagePicker: Bool = false
    @Binding var user: User?
    @Binding var isLoading: Bool
    @State private var imageChanged : Bool = false
    @State private var image : Image? = nil
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var inputImage: UIImage?
    @State var IsLoading: Bool = false
    @State var showingOptions: Bool = false
    
    var body: some View{
        HStack{
            
            Text(user?.username ?? "")
                .bold()
                .font(.system(size: 20))
                .foregroundColor(Color.black)
                .lineLimit(1)
            
            Spacer()
            
            ZStack(alignment: .top){
                
                ImageDownloader(height:80, width:80,imageURL: user?.pic ?? "", isCircleShape: true, placeHolder: { PlaceHolderView(circleShape: true) })
                    .id(UUID())
                    .cornerRadius(40)
                
                
                HStack{
                    
                    Spacer()
                    
                    Image("pencil")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.blue)
                        .cornerRadius(10)
                    
                }
                
            } .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                
                showingImagePicker = true
                
            }
            
        }.sheet(isPresented: $showingImagePicker, onDismiss: uploadImage)
        {
            
            ImagePicker(sourceType: self.sourceType, image: self.$inputImage)
            
        }.actionSheet(isPresented: $showingOptions) {
            ActionSheet(
                title: Text(""),
                buttons: [
                    .default(Text("Camera")) {
                        sourceType = .camera
                        showingImagePicker = true
                    },
                    
                    .default(Text("Photo Library")) {
                        sourceType = .photoLibrary
                        showingImagePicker = true
                    },
                    
                    .default(Text("Cancel")) {
                        showingOptions = false
                    },
                ]
                
            )
            
        }
        
        
    }
    
    func uploadImage()
    {
        
        guard let id = Auth.auth().currentUser?.uid else{
            isLoading = false
            return
        }
        
        guard let inputImage = inputImage else { return }
        guard let pic = inputImage.resized(withPercentage: 50) else{
            isLoading = false
            return
        }
        isLoading = true
        image = Image(uiImage: pic)
        
        self.imageChanged = true
        
        let data = inputImage.pngData()!
        let storage = Storage.storage()
        let ref = storage.reference().child("users/\(id).jpg")
        let uploadTask = ref.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                isLoading = false
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            
            // You can also access to download URL after upload.
            ref.downloadURL { (url, error) in
                
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    isLoading = false
                    return
                }
                image = nil
                user?.pic = downloadURL.absoluteString
                updateData()
                print(downloadURL)
                
            }
        }
        
    }
    
    func updateData(){
        guard let userID = Auth.auth().currentUser?.uid else{
            isLoading = false
            return
        }
        
        let collection = Firestore.firestore().collection("user")
        collection.document(userID)
            .updateData(["pic": user?.pic ?? ""]){
                error in
                isLoading = false
                if error?.localizedDescription == nil{
                    
                }else{
                    print("Updated")
                }
            }
    }
    
}
