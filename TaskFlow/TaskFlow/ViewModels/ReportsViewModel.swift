//
//  ReportsViewModel.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 31.10.2025.
//

import Foundation
import SwiftUI

@MainActor
class ReportsViewModel: ObservableObject {
    @Published var pdfFiles: [URL] = []
    @Published var showPDFPreview = false
    @Published var showShareSheet = false
    @Published var selectedPDF: URL?
    

    func loadPDFs() {
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("Reports")

        if !FileManager.default.fileExists(atPath: folder.path) {
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        }

        let files = (try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil)) ?? []
        pdfFiles = files.filter { $0.pathExtension.lowercased() == "pdf" }
    }
}
