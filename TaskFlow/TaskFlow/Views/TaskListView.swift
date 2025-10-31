//
//  TaskListView.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 28.10.2025.
//

import SwiftUI
import FirebaseFirestore

struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()
    @State private var selectedTask: Task?
    
    var body: some View {
        NavigationStack{
            
            VStack{
                if viewModel.tasks.isEmpty{
                    Text("No tasks found.")
                        .foregroundColor(.gray)
                        .padding(.top,50)
                }else {
                    List(viewModel.tasks){task in
                        NavigationLink(destination: TaskDetailView(task:task)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(task.title)
                                        .font(.headline)
                                    Text(task.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                
                                Circle()
                                    .fill(viewModel.colorForTask(task))
                                    .frame(width: 12, height: 12)
                            }
                            .padding(.vertical,8)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("My Tasks")
            .onAppear{
                viewModel.fetchUserTasks()
            }
        }
    }
}

#Preview {
    TaskListView()
}
