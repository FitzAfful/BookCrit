//
//  FirebaseService.swift
//  LibTrack
//
//  Created by Fitzgerald Afful on 09/03/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

typealias FirebaseAuthResult = AuthDataResult

protocol FirebaseHelperProtocol: class {
    func getCredentialFromGoogle(with googleUser: GIDGoogleUser) -> AuthCredential
    func getCredentialFromApple(with idToken: String, nonce: String) -> AuthCredential
    func loginUser(credential: AuthCredential, completion: @escaping (AuthDataResult?, Error?) -> Void)
}

class FirebaseHelper: FirebaseHelperProtocol {
    func getCredentialFromGoogle(with googleUser: GIDGoogleUser) -> AuthCredential {
        let authentication = googleUser.authentication
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)
        return credential
    }

    func getCredentialFromApple(with idToken: String, nonce: String) -> AuthCredential {
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idToken, rawNonce: nonce)
        return credential
    }

    func loginUser(credential: AuthCredential, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(with: credential) { (result, error) in
            completion(result, error)
        }
    }

}

enum AuthenticationError: Error {
    case invalidName
    case invalidPassword
    case userDisabled
    case emailAlreadyInUse
    case invalidEmail
    case wrongPassword
    case userNotFound
    case accountExistsWithDifferentCredential
    case networkError
    case credentialAlreadyInUse
    case unknown

    init(rawValue: Int) {
        switch rawValue {
        case 17005: self = .userDisabled
        case 17007: self = .emailAlreadyInUse
        case 17008: self = .invalidEmail
        case 17009: self = .wrongPassword
        case 17011: self = .userNotFound
        case 17012: self = .accountExistsWithDifferentCredential
        case 17020: self = .networkError
        case 17025: self = .credentialAlreadyInUse
        case 17026: self = .invalidPassword
        default: self = .unknown
        }
    }
}
