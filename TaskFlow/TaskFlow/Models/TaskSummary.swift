//
//  TaskSummary.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 28.10.2025.
//

import Foundation

struct TaskSummary: Identifiable {
    let id = UUID()
    let status: String
    let count: Int
}
