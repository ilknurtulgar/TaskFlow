//
//  PDFService.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 31.10.2025.
//

import PDFKit
import Foundation

class PDFService {
    static func createPDF(for task: Task) -> URL? {
        let pdfMeta = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842))
        let fileName = "\(task.title)_\(Date().timeIntervalSince1970).pdf"
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Reports")
        
        if !FileManager.default.fileExists(atPath: folder.path) {
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        }
        
        let fileURL = folder.appendingPathComponent(fileName)
        
        try? pdfMeta.writePDF(to: fileURL) { context in
            context.beginPage()
            let titleAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 24)]
            task.title.draw(at: CGPoint(x: 20, y: 20), withAttributes: titleAttributes)
            
            let bodyAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18)]
            task.description.draw(at: CGPoint(x: 20, y: 60), withAttributes: bodyAttributes)
            
            let statusString = "Status: \(task.status)"
            statusString.draw(at: CGPoint(x: 20, y: 100), withAttributes: bodyAttributes)
        }
        
        return fileURL
    }
}
