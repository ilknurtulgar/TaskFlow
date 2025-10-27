//
//  LoginViewModel.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 27.10.2025.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errMsg: String?
    
    @Published var isLoggedIn = false
    
    func signIn(){
        AuthService.shared.signIn(email: email, password: password){ [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errMsg = error
                    self?.isLoggedIn = false
                }else {
                    self?.errMsg = nil
                    self?.isLoggedIn = true
                }
            }
        }
    }
    
    
}
