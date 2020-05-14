//
//  Loader.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation

enum DownloadError: Error, Equatable {
    case isDownloading
    case downloadCancelled
    case downloadFailed(status: Int)
}

extension DownloadError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .isDownloading:
            return "Download is in progress"
        case .downloadCancelled:
            return "Download cancelled."
        case .downloadFailed(let status):
            return "Failed to download file, status: \(status)"
        }
    }
}

fileprivate let urlString = "https://www.w3schools.com/xml/cd_catalog.xml"

typealias DownloadCompletion = (_ result: Data?, _ error: DownloadError?) -> Void

class Loader: NSObject {
    static let shared = Loader()
    fileprivate var isLoading = false
    
    func load(completion: @escaping DownloadCompletion) {
        if isLoading {
            completion(nil, .isDownloading)
            return
        }
        
        asyncBack {
            if let url = URL(string: urlString) {
                let sessionConfig = URLSessionConfiguration.default
                let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
                let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                    asyncMain {
                        self?.isLoading = false
                        
                        // make sure we have a 2XX http status
                        if let status = (response as? HTTPURLResponse)?.statusCode, status < 200 || status > 299 {
                            completion(nil, .downloadFailed(status: status))
                        }
                        // check if the download was cancelled or another error was returned
                        else if let downloadError = error {
                            let status = (downloadError as NSError).code
                            completion(nil, status == NSURLErrorCancelled ? .downloadCancelled : .downloadFailed(status: status))
                        }
                        // success
                        else {
                            completion(data, nil)
                        }
                    }
                }
                
                self.isLoading = true
                task.resume()
            }
        }
    }
}
