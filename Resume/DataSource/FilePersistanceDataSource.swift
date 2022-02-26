//
//  FilePersistanceDataSource.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 26/2/2565 BE.
//

import Foundation

class FilePersistanceDataSource: IResumeDataSource {
    
    private lazy var resumes: [Resume] = {
        do {
            if FileManager.default.fileExists(atPath: localFile.standardizedFileURL.path) {
                let data = try Data(contentsOf: localFile)
                return try JSONDecoder().decode([Resume].self, from: data)
            }
        } catch {
            print(error)
        }
        return []
    }()
    
    private var localFile: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent("resumes.json")
    }
    
    private func writeToFile() {
        do {
            let data = try JSONEncoder().encode(resumes)
            try data.write(to: localFile)
        } catch {
            print(error)
        }
    }
    
    func getAll() -> [Resume] {
        return resumes
    }
    
    func get(id: String) -> Resume? {
        return resumes.first { $0.id == id }
    }
    
    func create(resume: Resume) {
        resumes.append(resume)
        writeToFile()
    }
    
    func update(resume: Resume) {
        let index = resumes.firstIndex { $0 == resume }
        guard let index = index else {
            print("Save fail")
            return
        }
        resumes[index] = resume
        writeToFile()
    }
    
    func delete(resume: Resume) {
        resumes.removeAll { $0 == resume }
        writeToFile()
    }
    
}
