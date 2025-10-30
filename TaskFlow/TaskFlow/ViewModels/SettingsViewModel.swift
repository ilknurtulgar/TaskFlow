//
//  SettingsViewModel.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 30.10.2025.
//

import SwiftUI
import FirebaseAuth

class SettingsViewModel: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    func signOut(){
        do {
            try Auth.auth().signOut()
        }catch{
            print("Sign out error: \(error.localizedDescription)")
        }
    }
}
