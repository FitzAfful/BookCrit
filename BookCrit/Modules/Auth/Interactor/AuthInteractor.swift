//
//  LoginInteractor.swift
//  RideAlong
//
//   on 16/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//

import Foundation
import GoogleSignIn
import FirebaseAuth
import TwitterKit

class AuthInteractor: AuthUseCase {

    var output: AuthInteractorOutput!


    func firebaseGoogleLogin(with googleUser: GIDGoogleUser) {
        let authentication = googleUser.authentication
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)
        Auth.auth().signIn(with: credential) { (result, error) in
            self.signedIn(error: error, result: result, phoneNumber: nil, name: nil, isEmail: false,  email: "", password: "")
        }
    }

    func firebaseAppleLogin(with idToken: String, nonce: String){
        print(nonce)
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idToken, rawNonce: nonce)
        Auth.auth().signIn(with: credential) { (result, error) in
            self.signedIn(error: error, result: result, phoneNumber: nil, name: nil, isEmail: false,  email: "", password: "")
        }
    }


    func firebaseEmailLogin(with email: String, password: String, phoneNumber: String, name: String) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        print("Email Login")
        Auth.auth().signIn(with: credential) { (result, error) in
            self.signedIn(error: error, result: result, phoneNumber: phoneNumber, name: name, isEmail: true,  email: email, password: password)
        }
    }

    func firebaseEmailRegister(with email: String, password: String, phoneNumber: String, name: String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            self.signedIn(error: error, result: result, phoneNumber: phoneNumber, name: name, isEmail: true, email: email, password: password)
        }
    }


    func firebaseTwitterLogin(){
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if (error != nil) {
                self.signedIn(error: error, result: nil, phoneNumber: nil, name: nil, isEmail: false,  email: "", password: "")
                return
            }
            let credential = TwitterAuthProvider.credential(withToken: (session?.authToken)!, secret: (session?.authTokenSecret)!)
            Auth.auth().signIn(with: credential) { (result, error) in
                self.signedIn(error: error, result: result, phoneNumber: nil, name: nil, isEmail: false,  email: "", password: "")
            }
        }
    }

    func firebaseFacebookLogin(with token: String){
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        Auth.auth().signIn(with: credential) { (result, error) in
            self.signedIn(error: error, result: result, phoneNumber: nil, name: nil, isEmail: false, email: "", password: "")
        }
    }


    func forgotPassword(with email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if(error != nil){
                print(error!.localizedDescription)
                self.output.onForgotPasswordFailure(message: error!.localizedDescription)
                return
            }
            self.output.onForgotPasswordSuccess()
        }
    }

    func signedIn(error: Error?, result: AuthDataResult?, phoneNumber: String?, name: String?, isEmail: Bool, email: String, password: String ) {
        if(error != nil){
            print("Phone: \(phoneNumber), name: \(name), Error is not nil \(error)")
            if let errorCode = AuthErrorCode(rawValue: error!._code) {
                switch errorCode {
                case.wrongPassword:
                    self.output.onSignInFailure(message:"You entered an invalid password please try again!")
                case.userNotFound:
                    print("User not found")
                    if(isEmail){
                        print("Email User \(password)")
                        self.firebaseEmailRegister(with: email, password: password, phoneNumber: "-", name: "-")
                        return
                    }else {
                        print("User not found II")
                        self.output.onSignInFailure(message:"User not found. Please create an account")
                    }
                case .weakPassword:
                    self.output.onSignInFailure(message:"You entered a weak password. Please choose another!")
                case .accountExistsWithDifferentCredential:
                    self.output.onSignInFailure(message:"This account exists with different credential")
                default:
                    self.output.onSignInFailure(message: "Unexpected error \(errorCode.rawValue) please try again!")
                    print("Creating user error \(error.debugDescription)!")
                }
            }
        }else if(result != nil){
            print("Error is nil")
            var email = ""
            let user = result!.user
            if(user.email != nil){
                email = user.email!
            }else if(user.providerData[0].email != nil){
                email = user.providerData[0].email!
            }

            var image = ""
            if(user.photoURL != nil){
                image = user.photoURL!.absoluteString
            }

            var displayName = ""
            if let disp = user.displayName {
                displayName = disp
            }

            if(displayName == ""){
                if(name != nil){
                    displayName = name!
                }else{
                    displayName = email
                }
            }

            if isEmail {
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = name!
                    changeRequest.photoURL =
                        URL(string: "https://example.com/jane-q-user/profile.jpg")
                    changeRequest.commitChanges { error in
                    }
                }
            }

            var contName = ""
            if let cont = phoneNumber {
                contName = cont
            }

            let parameter = ServerAuthParameter(first_name: "", username: email, last_name: "", name: displayName, refferal_id: "7eab57", institute: "Ghana Law School", email: email, image_url: image, firebase_uid: user.uid, city: "Accra", country: "Ghana", contact: contName, device_id: UIDevice.current.identifierForVendor!.uuidString, push_registration_id: DefaultsManager().getFCMToken(), platform: "iOS", ip: UtilityHelper().getIPAddress(), content_provider_id: "73")
            print(parameter)
            self.serverLogin(with: parameter)
        }
    }


    func serverLogin(with param: ServerAuthParameter) {
        AuthNetworkManager.customerAuth(parameter: param) { (result) in
            switch result.result {
            case .success(let response):
                
                DefaultsManager().setLoginState(loginState: true)
                DefaultsManager().setUser(user: response.user)
                self.output.onSignInSuccess()
                break
            case .failure(_):
                self.output.onSignInFailure(message: NetworkManager().getErrorMessage(response: result))
            }
        }
    }

}
