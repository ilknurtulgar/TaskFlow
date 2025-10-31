//
//  TaskDetailView.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 31.10.2025.
//

import SwiftUI

struct TaskDetailView: View {
    @StateObject private var viewModel: TaskDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(task: Task) {
        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewModel.task.title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(viewModel.task.description)
                .font(.body)
            
            if let sla = viewModel.task.duration {
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                    Text("SLA: \(sla) h")
                        .foregroundColor(viewModel.slaColor())
                }
            }
            
            HStack {
                Image(systemName: viewModel.task.status == "Completed" ? "checkmark.seal.fill" : "hourglass")
                    .foregroundColor(viewModel.task.status == "Completed" ? .green : .orange)
                Text("Status: \(viewModel.task.status)")
                    .foregroundColor(viewModel.task.status == "Completed" ? .green : .orange)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationTitle("Task Detail")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("Pending") { viewModel.setStatus("Pending") }
                    Button("In Progress") { viewModel.setStatus("In Progress") }
                    Button("Completed") { viewModel.setStatus("Completed") }
                } label: {
                    Label("Change Status", systemImage: "ellipsis.circle")
                }
            }
        }
    }
}



#Preview {
    TaskDetailView(task: Task(title: "ilknur", description: "ss", status: "Completed"))
}
