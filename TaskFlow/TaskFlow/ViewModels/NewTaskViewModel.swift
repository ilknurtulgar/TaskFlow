//
//  NewTaskViewModel.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 30.10.2025.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class NewTaskViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var sla: String = ""
    @Published var assignedTo: String = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func saveTask() {
        guard !title.isEmpty, !description.isEmpty, !sla.isEmpty, !assignedTo.isEmpty else {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }
        
        let db = Firestore.firestore()
        let taskData: [String: Any] = [
            "title": title,
            "description": description,
            "sla": sla,
            "assignedTo": assignedTo,
            "createdAt": Timestamp(),
            "status": "Pending"
        ]
        
        db.collection("tasks").addDocument(data: taskData){error in
            if let error = error {
                self.alertMessage = "Error saving task: \(error.localizedDescription)"
            } else {
                self.alertMessage = "Task successfully created!"
                self.title = ""
                self.description = ""
                self.sla = ""
                self.assignedTo = ""
            }
            self.showAlert = true
        }
    }
}
