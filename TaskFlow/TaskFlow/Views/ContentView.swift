//
//  ContentView.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 27.10.2025.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @ObservedObject var auth = AuthService.shared
    
    var body: some View {
        Group{
            if auth.currentUser != nil {
                HomeView()
            }else
            {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
