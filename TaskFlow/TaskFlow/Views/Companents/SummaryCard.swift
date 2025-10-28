//
//  SummaryCard.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 28.10.2025.
//

import SwiftUI
import Foundation

struct SummaryCard: View{
    let title: String
    let count: Int
    
    var body: some View{
        VStack{
            Text("\(count)")
                .font(.title)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 100, height: 80)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
