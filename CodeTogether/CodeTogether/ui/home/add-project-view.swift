
import SwiftUI
import Firebase

struct AddProjectView: View {
    
    @Binding var showAddProjectView: Bool
    
    
    @State var project: Project? = Project()
    @State var alertMessage: String = ""
    @State var shouldShowAlert: Bool = false
    @State var isLoading: Bool = false
    @State var successToast: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .center){
            
            if !isLoading {
                
                VStack{
                    //            GeometryReader{ geo in
                    ScrollView(showsIndicators: false){
                        VStack{
                            AddProjectProfileHeader(project: $project)
                            
                            AddProjectAboutView(project: $project)
                                .padding(.top)
                            
                            AddProjectSkillsView(project: $project)
                                .padding(.top)
                            
                            MyMapAddProjectView(project: $project, showAlert: $shouldShowAlert, msg: $alertMessage)
                                .padding(.top)
                            
                            AddProjectContactInformationView(project: $project)
                                .padding(.top)
                            
                            Button {
                                showAddProjectView = true
                            } label: {
                                
                                Text("Add")
                                    .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        if validate(){
                                            if let name = project?.name, let skills = project?.skills,
                                               let description = project?.description, let noOfDevelopers = project?.no_of_developers, let userId = Auth.auth().currentUser?.uid{
                                                isLoading = true
                                                let docRef = Firestore.firestore()
                                                    .collection("project_proposal")
                                                    .document()
                                                let id = docRef.documentID
                                                guard let userID = Auth.auth().currentUser?.uid else{
                                                    return
                                                }
                                                let collection = Firestore.firestore().collection("project_proposal")
                                                collection.document(id)
                                                    .setData(["name": name,
                                                              "skills": skills,
                                                              "description": description,
                                                              "no_of_developers": noOfDevelopers,
                                                              "user_id": userID
                                                              
                                                    ]){
                                                        error in
                                                        isLoading = false
                                                        if let _ = error?.localizedDescription{
                                                            alertMessage = "Unable to add a new project. Please check your internet connection and try again."
                                                            shouldShowAlert = true
                                                        }else{
                                                            successToast = true
                                                            project = Project()
                                                        }
                                                        print("Updated")
                                                    }
                                            }
                                            
                                        }else{
                                            shouldShowAlert = true
                                        }
                                    }
                                
                            }.padding(.top, 20)
                            
                            
                        }.padding()
                    }
                } .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(false)
                
            }else{
                ProgressView("Loading")
            }
            
        }.alert(isPresented: $shouldShowAlert, content: {
            Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            
        }).toast(isPresenting: $successToast){
            AlertToast(type: .regular, title: "Successfully Added")
        }
    }
    
    func validate() -> Bool{
        let valid = true
        if project?.name?.count == 0{
            alertMessage = "Project Name should not be empty"
            return false
        }
        
        if project?.description?.count == 0{
            alertMessage = "Description should not be empty"
            return false
        }
        
        if project?.skills?.count == 0{
            alertMessage = "Please add atleast one skill"
            return false
        }
        
        if project?.lat == 0.0 || project?.lng == 0.0{
            alertMessage = "Please add location first."
            return false
        }
        
        if project?.no_of_developers?.count == 0{
            alertMessage = "Please enter total numbers of developers"
            return false
        }
        
        return valid
    }
    
}

struct AddProjectAboutView: View {
    
    @Binding var project: Project?
    @State var displayEditAbout: Bool = false
    @State var about: String? = ""
    
    var body: some View{
        
        VStack(alignment: .leading){
            HStack{
                Text("Description")
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
                        //                        dialog()
                    }
            }
            
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text(project!.description ?? "")
                .font(.system(size: 12))
                .foregroundColor(Color.black)
            
            
        } .sheet(isPresented: $displayEditAbout) {
            CustomMultilineTextFieldAlert(prompt: "Enter Description", value: $about)
        }
        .onChange(of: about, perform: { value in
            if let value = about, about?.count ?? 0 > 0{
                project?.description = value
            }
        })
    }
}

import MapKit

struct MyMapAddProjectView: View {
    
    
    @State var user: User? = nil
    
    @Binding var project: Project?
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
            latitudeDelta: 10,
            longitudeDelta: 10
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
                        
                        project?.lat = Double(userLatitude)
                        project?.lng = Double(userLongitude)
                        
                        region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: (project?.lat)!,
                                longitude: (project?.lng)!
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
            
            if user != nil{
                
                let location =  Location(coordinate: .init(latitude: user?.lat ?? 31.7683, longitude: user?.lng ?? 35.2137))
                
                annoations.append(location)
                project?.lat = user?.lat
                project?.lng = user?.lng
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
            getDocument()
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



struct AddProjectContactInformationView: View {
    
    @Binding var project: Project?
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("No of Developers")
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
            
            VStack(alignment: .leading){
                
                Text(project?.no_of_developers ?? "")
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.top)
                
            }.padding(.top)
            
        }
    }
    
    func dialog(){
        
        let alertController = UIAlertController(title: "No of Developers", message: "Please enter number of developers required", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "No of Developers"
            textField.keyboardType = .numberPad
        }
        
        let saveAction = UIAlertAction(title: "Done", style: .default, handler: { alert -> Void in
            
            let secondTextField = alertController.textFields![0] as UITextField
            
            project?.no_of_developers = secondTextField.text
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        
    }
}

struct AddProjectSkillsView: View {
    
    @State var displayEditSheet: Bool = false
    @Binding var project: Project?
    
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
                ForEach(project?.skills ?? [], id: \.self){ skill in
                    SkillView(skill: skill)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }
            
            
        }.onAppear{
            if project?.skills == nil{
                project?.skills = []
            }
            if let skills = project?.skills{
                self.skills = skills
            }
        } .sheet(isPresented: $displayEditSheet) {
            EditContactInfoAlert(value: $skills, prompt: "Add Skill")
        }
        .onChange(of: skills, perform: { value in
            if let value = skills, skills?.count ?? 0 > 0{
                project?.skills = skills
            }
        })
        //        }
    }
    
}

struct AddProjectCustomDivider: View {
    
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

struct AddProjectProfileHeader: View{
    
    @Binding var project: Project?
    @State var projectName: String = ""
    
    
    var body: some View{
        VStack(alignment: .leading){
            
            Text("Project Name")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(Color.black)
                .lineLimit(1)
            
            CustomDivider()
                .frame(height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            TextField("Project Name", text: $projectName)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top)
            
        }.onChange(of: projectName, perform: { value in
            project!.name = projectName
        })
        .onChange(of: project?.name, perform: { value in
            projectName = project?.name ?? ""
        })
        
        .onAppear{
            projectName = self.projectName
        }
    }
}
