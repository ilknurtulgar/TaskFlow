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
    
    private var db = Firestore.firestore()
    
    init(){
        //fetchTasks()
    }
    
    
    
    func signOut(){
        do {
            try Auth.auth().signOut()
        }catch{
            print("Sign out error: \(error.localizedDescription)")
        }
    }
}
