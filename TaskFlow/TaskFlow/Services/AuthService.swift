//
//  AuthService.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 27.10.2025.
//

import Foundation
import FirebaseAuth

class AuthService: ObservableObject {
    static let shared = AuthService()
    
    @Published var currentUser: User?
    
    private init() {
        listenAuthState()
    }
    
    private func listenAuthState() {
        Auth.auth().addStateDidChangeListener{ [weak self] _, firebaseUser in
            guard let self = self else {return}
            
            if let firebaseUser = firebaseUser{
                self.currentUser = User(uid: firebaseUser.uid, email: firebaseUser.email ?? "", role: "user")
            } else {
                self.currentUser = nil
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (String?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password){result, error in
            if let error = error {
                completion(error.localizedDescription)
            }else {
                completion(nil)
            }
        }
    }
    
    func signOut(){
        try? Auth.auth().signOut()
        self.currentUser = nil
    }
}
