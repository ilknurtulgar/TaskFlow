//
//  LoginView.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 27.10.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var model = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 16){
            TextField("Email",text: $model.email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $model.password)
                .textFieldStyle(.roundedBorder)
            
            if let errMsg = model.errMsg{
                Text(errMsg)
                    .foregroundColor(.red)
            }
            
            Button("Sign In"){
                model.signIn()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
