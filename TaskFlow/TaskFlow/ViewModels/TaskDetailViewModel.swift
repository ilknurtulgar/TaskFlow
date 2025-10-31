//
//  TaskDetailView.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 31.10.2025.
//

import SwiftUI
import FirebaseFirestore


@MainActor
class TaskDetailViewModel: ObservableObject {
    @Published var task: Task
    @Published var showUpdateView = false
    
    private let db = Firestore.firestore()
    
    init(task: Task) {
        self.task = task
    }
    
    func advanceStatus() {
        guard let taskId = task.id else { return }
        
        var newStatus = task.status
        switch task.status {
        case "Pending":
            newStatus = "In Progress"
        case "In Progress":
            newStatus = "Completed"
        case "Completed":
            return
        default:
            return
        }
        
        db.collection("tasks").document(taskId).updateData(["status": newStatus]) { error in
            if let error = error {
                print("Error updating status: \(error.localizedDescription)")
            } else {
                self.task.status = newStatus
                print("Task status updated to \(newStatus)")
            }
        }
    }
    
    func slaColor() -> Color {
        guard let duration = task.duration,
              let created = task.createdAt else {
            return .gray
        }
        
        let elapsedHours = Date().timeIntervalSince(created) / 3600
        let remaining = Double(duration) - elapsedHours
        
        if remaining <= 0 {
            return .red
        } else if remaining < 24 {
            return .orange
        } else {
            return .green
        }
    }
    
    func setStatus(_ newStatus: String) {
        guard let id = task.id else { return }
        db.collection("tasks").document(id).updateData(["status": newStatus]) { error in
            if let error = error {
                print("Error updating status: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.task.status = newStatus
                    print("Status updated to \(newStatus)")
                }
            }
        }
    }
    
}
