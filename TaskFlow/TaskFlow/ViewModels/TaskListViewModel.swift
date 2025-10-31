//
//  TaskListViewModel.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 31.10.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUICore

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    private var db = Firestore.firestore()
    
    func fetchUserTasks() {
        guard let currentUserEmail = Auth.auth().currentUser?.email else {
            return
        }
        print("\(currentUserEmail)")
        db.collection("tasks")
            .whereField("assignedTo", isEqualTo: currentUserEmail)
            .addSnapshotListener{querySnapshot, error in
            if let error = error {
                print("error fetching tasks: \(error.localizedDescription)")
                return
                }
                
                self.tasks = querySnapshot?.documents.compactMap{doc in
                    try? doc.data(as: Task.self)
                } ?? []
            }
    }
    
    func colorForTask(_ task: Task) -> Color {
        guard let totalHours = task.duration,
              let created = task.createdAt else {
            return .gray
        }

        let elapsedSeconds = Date().timeIntervalSince(created)
        let elapsedHours = elapsedSeconds / 3600.0
        let remaining = Double(totalHours) - elapsedHours

        if remaining <= 0 {
            return .red
        } else if remaining < 24 {
            return .orange
        } else {
            return .green
        }
    }

}
