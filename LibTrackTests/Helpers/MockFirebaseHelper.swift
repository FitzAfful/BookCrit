//
//  MockFirebaseHelper.swift
//  LibTrackTests
//
//  Created by Hosny Savage on 29/01/2021.
//  Copyright © 2021 LibTrack. All rights reserved.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

class MockFirebaseHelper: FirebaseHelperProtocol {
    func getCredentialFromGoogle(with googleUser: GIDGoogleUser) -> AuthCredential {
        
    }
    
    func getCredentialFromApple(with idToken: String, nonce: String) -> AuthCredential {
        
    }
    
    func loginUser(credential: AuthCredential, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        
    }
    
    
    
}
