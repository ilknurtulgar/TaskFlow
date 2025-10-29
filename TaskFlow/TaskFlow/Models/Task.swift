//
//  Task.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 29.10.2025.
//

import Foundation
import FirebaseFirestore

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var description: String
    var status: String
    var assignedTo: String?
    var dueDate: Date?
}
