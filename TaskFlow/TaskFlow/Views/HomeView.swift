//
//  HomeView.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 24.10.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var model = HomeViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading,spacing: 10){
                
                Text("TaskFlow")
                    .font(.largeTitle.bold())
                
                Text("General Summary")
                    .font(.headline)
                
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        SummaryCard(title: "Pending",count: model.pendingCount)
                        SummaryCard(title: "Active",count: model.activeCount)
                        SummaryCard(title: "Completed",count: model.completedCount)
                        SummaryCard(title: "Work Time",count: model.workHours)
                    }
                }
                Divider()
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16){
                    NavigationLink(destination: TaskListView()){
                        HomeCard(title: "Tasks",subtitle: "see all tasks")
                    }
                    
                    NavigationLink(destination: ReportsView()){
                        HomeCard(title: "Reports", subtitle: "View your reports")
                    }
                    
                    NavigationLink(destination: LocationView()){
                        HomeCard(title: "Location", subtitle: "Check your location")
                    }
                    
                    NavigationLink(destination: SettingsView(homeViewModel:model)){
                        HomeCard(title: "Settings",subtitle: "see all tasks")
                    }
                    
                }
                .padding(.top,8)
                
                if model.userRole == "admin" {
                    NavigationLink(destination: NewTaskView()) {
                        Label("New Task", systemImage: "plus.circle.fill")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.top, 16)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    HomeView()
}
