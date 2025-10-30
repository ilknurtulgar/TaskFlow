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
    //    @Published var tasksSummary: [TaskSummary] = [
    //        TaskSummary(status: "Planned", count: 2),
    //        TaskSummary(status: "To be done", count: 4),
    //        TaskSummary(status: "In the study", count: 2),
    //        TaskSummary(status: "Checking", count: 1),
    //        TaskSummary(status: "Completed", count: 5)
    //    ]
    
    @Published var tasks: [Task] = []
    @Published var userRole: String = "admin"
    @Published var tasksSummary: [TaskSummary] = []
    
    @Published var pendingCount: Int = 0
    @Published var activeCount: Int = 0
    @Published var completedCount: Int = 0
    @Published var workHours: Int = 0
    
    private var db = Firestore.firestore()
    
    init(){
        fetchTasks()
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
    
    
    func signOut(){
        do {
            try Auth.auth().signOut()
        }catch{
            print("Sign out error: \(error.localizedDescription)")
        }
    }
}
