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
                
                Text("Task Summary")
                    .font(.headline)
                
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        ForEach(model.tasksSummary){summary in
                            SummaryCard(title: summary.status,count: summary.count)
                        }
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
