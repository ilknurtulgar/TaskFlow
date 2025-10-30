//
//  NewTaskView.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 29.10.2025.
//

import SwiftUI

struct NewTaskView: View {
    @StateObject private var viewModel = NewTaskViewModel()
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Task Details")){
                    TextField("Title", text: $viewModel.title)
                    TextField("Description",text: $viewModel.description)
                    TextField("SLA Duration",text: $viewModel.sla)
                    TextField("Assigned to",text: $viewModel.assignedTo)
                }
                
                Section{
                    Button(action: {
                        viewModel.saveTask()
                    }){
                        Label("Save Task", systemImage: "checkmark.circle.fill"
                        ).frame(maxWidth: .infinity,alignment: .center)
                    }
                }
            }
            .navigationTitle("New Task")
            .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert){
                Button("Ok",role: .cancel){
                    
                }
            }
        }
    }
}

#Preview {
    NewTaskView()
}
