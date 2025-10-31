//
//  ReportsView.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 28.10.2025.
//

import SwiftUI

struct ReportsView: View {
    @StateObject private var viewModel = ReportsViewModel()
   
    var body: some View {
           NavigationStack {
               List(viewModel.pdfFiles, id: \.self) { pdf in
                   VStack(alignment: .leading) {
                       HStack {
                           Image(systemName: "doc.richtext")
                               .foregroundColor(.blue)
                           Text(pdf.lastPathComponent)
                               .lineLimit(1)
                           Spacer()
                       }
                       
                       HStack(spacing: 16) {
                           Button("Open PDF") {
                               viewModel.selectedPDF = pdf
                                   viewModel.showPDFPreview = true
                           }
                           .buttonStyle(.bordered)

                           Button("Share PDF") {
                               viewModel.selectedPDF = pdf
                                   viewModel.showShareSheet = true
                           }
                           .buttonStyle(.borderedProminent)
                       }
                   }
                   .padding(.vertical, 8)
               }
               .navigationTitle("Reports")
               .onAppear {
                   viewModel.loadPDFs()
               }
               .sheet(isPresented: $viewModel.showPDFPreview) {
                   if let url = viewModel.selectedPDF {
                       PDFPreview(url: url)
                   }
               }
               .sheet(isPresented: $viewModel.showShareSheet) {
                   if let url = viewModel.selectedPDF {
                       ActivityView(activityItems: [url])
                   }
               }
           }
       }
}


#Preview {
    ReportsView()
}
