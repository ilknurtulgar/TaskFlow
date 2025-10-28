//
//  HomeCard.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 28.10.2025.
//

import SwiftUI

struct HomeCard: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

