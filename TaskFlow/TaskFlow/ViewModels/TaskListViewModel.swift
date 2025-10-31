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
        guard let duration = task.duration else {return .gray}
        if duration < 24 {
            return .red
        }else if duration < 48 {
            return .orange
        }else {
            return .green
        }
    }
}
