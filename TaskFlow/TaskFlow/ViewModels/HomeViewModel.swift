//
//  HomeViewModel.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 28.10.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    @Published var userRole: String = "user"
    @Published var tasksSummary: [TaskSummary] = []
    
    @Published var pendingCount: Int = 0
    @Published var activeCount: Int = 0
    @Published var completedCount: Int = 0
    @Published var workHours: Int = 0
    
    private var db = Firestore.firestore()
    
    init(){
        fetchUserRole()
        fetchTasks()
    }
    
    func fetchUserRole() {
        guard let email = Auth.auth().currentUser?.email else { return }

        db.collection("users")
            .whereField("email", isEqualTo: email)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching user role: \(error.localizedDescription)")
                    return
                }

                if let doc = snapshot?.documents.first,
                   let role = doc.data()["role"] as? String {
                    DispatchQueue.main.async {
                        self.userRole = role
                        print("User role: \(role)")
                    }
                } else {
                    print("Role not found")
                }
            }
    }




    
    func fetchTasks(){
        db.collection("tasks").addSnapshotListener{querySnapshot,error in
            guard let doc = querySnapshot?.documents else {
                print("no tasks found")
                return
            }
            
            self.tasks = doc.compactMap{doc -> Task? in
                try?  doc.data(as: Task.self)
            }
            self.updateSummary()
        }
    }
    
    func updateSummary() {
        let grouped = Dictionary(grouping: tasks, by: { $0.status })
        self.tasksSummary = grouped.map { status, tasks in
            TaskSummary(status: status, count: tasks.count)
        }
        
        self.pendingCount = grouped["Planned"]?.count ?? 0
           self.activeCount = grouped["In Progress"]?.count ?? 0
           self.completedCount = grouped["Completed"]?.count ?? 0

           self.workHours = tasks.filter { $0.status == "Completed" }
            .reduce(into: 0) { $0 + ($1.duration ?? 0) }
    }

}
