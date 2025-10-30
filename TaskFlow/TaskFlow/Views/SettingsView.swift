//
//  SettingsView.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 28.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @StateObject private var settingsViewModel = SettingsViewModel()
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Toggle(isOn: $isDarkMode) {
                    Label("Dark Mode", systemImage: "moon.fill")
                        .foregroundColor(.gray)
                }
                .onChange(of: isDarkMode) { value in
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = value ? .dark : .light
                }
            }
            
            Section(header: Text("Account")) {
                Button(role: .destructive) {
                    settingsViewModel.signOut()
                    dismiss()
                } label: {
                    Label("Sign Out",systemImage: "escape")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView(homeViewModel: HomeViewModel())
}
