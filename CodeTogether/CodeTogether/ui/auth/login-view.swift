
import SwiftUI
import Firebase

struct LoginView: View {
    
    @Binding var appState: AppStartUpState
    
    @State var Username: String = ""
    @State var Password: String = ""
    
    @State var IsLoading: Bool = false
    @State var showAlert = false
    @State var showForgetPassword = false
    @State var alertMessage: String = ""
    @State var showToast: Bool = false
    @State var toastMsg: String = ""
    @State var msg: String = ""
    @State var email: String? = ""

    var body: some View {
            GeometryReader { geo in
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading)
                    {
                        
                        CircularLogoView()
                        
                        HStack {
                            Text("Sign In")
                                .bold()
                                .font(.system(size: 25))
                                .foregroundColor(Color.black)
                        }
                        VStack(alignment: .leading){
                            Text("Hi there nice to see you again")
                                .bold()
                                .padding(.top)
                                .foregroundColor(Color.gray)
                            
                            Text("Email")
                                .bold()
                                .padding(.top, 50)
                                .foregroundColor(Color.blue)
                            
                            
                            TextField("Email", text: $Username)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                            Divider()
                                .padding(.top)
                            
                            Text("Password")
                                .bold()
                                .padding(.top)
                                .foregroundColor(Color.blue)
                            
                            
                            SecureField("Password", text: $Password)
                            
                            Divider()
                                .padding(.top)
                            HStack{
                                Spacer()
                                Text("Forget Password?")
                                    .bold()
                                    .padding(.top)
                                    .foregroundColor(Color.blue)
                                    .onTapGesture {
                                        self.dialog()
                                    }
                                   
                            }.padding(.bottom)
                        }
                        
                        
                        Text("Login")
                            .frame(width: geo.size.width, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .onTapGesture
                            {
                                login()
                            }
                        
                        
                        
                        
                        HStack{
                            Spacer()
                            Text("Don't have an account?")
                                .bold()
                                .padding(.top)
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            
                            Text("SignUp")
                                .bold()
                                .padding(.top)
                                .foregroundColor(Color.blue)
                                .onTapGesture{
                                    appState = .SignUp
                                }
                            
                            
                            Spacer()
                        }
                        
                    }
                }
            }.padding(20)
            .toast(isPresenting: $showToast){
                AlertToast(type: .regular, title: toastMsg)
            }.alert(isPresented: $showAlert, content: {
                Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))

            })
            .toast(isPresenting: $IsLoading){
                AlertToast(type: .loading, title: "Loading", subTitle: "")
            }
        
    }
    
    func dialog(){

           let alertController = UIAlertController(title: "Enter Email", message: "A link to reset password will be sent to your email.", preferredStyle: .alert)

            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Email"
            }

            let saveAction = UIAlertAction(title: "Send", style: .default, handler: { alert -> Void in

                let secondTextField = alertController.textFields![0] as UITextField
                
                callResetPassword(email: secondTextField.text ?? "")
            })

            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )

            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            

            UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)


        }
    
    func callResetPassword(email: String){
        IsLoading = true
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            IsLoading = false
            if let msg = error?.localizedDescription{
                alertMessage = msg
                showAlert = true
            }else{
                toastMsg = "Successfully Sent"
                showToast = true
                
            }
        }
    }
    
    func login(){
        if validate(){
            IsLoading = true
            Auth.auth().signIn(withEmail: Username, password: Password) {  authResult, error in
                IsLoading = false
                if let description =  error?.localizedDescription {
                    alertMessage = description
                    showAlert = true
                }else{
                    toastMsg = "Login Successfully"
                    showToast = true
                    appState = .Home
                    print("Login Successful")
                    
                }
                
            }
        }else{
            showAlert = true
        }
    }
    
    func validate() -> Bool{
        let valid = true
        if Username.count == 0{
            alertMessage = "Email should not be empty"
            return false
        }
        
        if !Username.contains("@"){
            alertMessage = "Invalid Email"
            return false
        }
        
        if Password.count == 0{
            alertMessage = "Password should not be empty"
            return false
        }
        
        if Password.count < 5{
            alertMessage = "Password is too short. It must be at least 6 characters long"
            return false
        }
        
        return valid
    }
    
}
