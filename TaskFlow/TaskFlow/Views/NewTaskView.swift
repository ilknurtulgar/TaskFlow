//
//  NewTaskView.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 29.10.2025.
//

import SwiftUI

struct NewTaskView: View {
    @StateObject private var viewModel = NewTaskViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Task Details")){
                    TextField("Title", text: $viewModel.title)
                    TextField("Description",text: $viewModel.description)
                    TextField("SLA Duration", value: $viewModel.sla, formatter: NumberFormatter())
                        .keyboardType(.numberPad)

                    TextField("Assigned to",text: $viewModel.assignedTo)
                }
                
                Section{
                    Button(action: {
                        viewModel.saveTask{ success in
                            if success {
                                dismiss()
                            }
                        }
                        
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
