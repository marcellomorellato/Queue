//
//  ViewModel.swift
//  Queue
//
//  Created by Marcello Morellato on 28/10/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var operationsQueue = OperationQueue()
    @Published var downloadStatus = ""
    @Published var progressStatus = ""
    
    init(){
        operationsQueue.maxConcurrentOperationCount = 1
    }
    
    func startDownloads(){
        
        for index in 1...100 {
            let downloadTask1 = DownloadOperationTask(url: URL(string: "https://example.com/image\(index).jpg")!,
                                                      destinationURL: URL(fileURLWithPath: "/path/to/save/image\(index).jpg"),
                                                      binaryIdentifier: "\(index)") { [weak self] in
                DispatchQueue.main.async {
                    self?.updateDownloadStatus()
                }
            } progressHandler: { [weak self] binaryId in
                DispatchQueue.main.async {
                    self?.updateProgress(binaryId)
                }
            }
            operationsQueue.addOperation(downloadTask1)
        }
        
    }
    
    func increasePriority(binaryIdentifier: String) {
        operationsQueue.isSuspended = true
        
        if let prioritizedOperation = operationsQueue.operations.first(where: { $0 is DownloadOperationTask && ($0 as! DownloadOperationTask).binaryIdentifier == binaryIdentifier }) {
            prioritizedOperation.queuePriority = .veryHigh
        }
        operationsQueue.isSuspended = false
    }
    
    func updateProgress(_ binaryIdentifier: String){
        progressStatus = "current download id : \(binaryIdentifier)"
    }
    
    func updateDownloadStatus() {
        let totalOperationCount = operationsQueue.operationCount
        let newStatus = "downloads \(totalOperationCount)"
        
        if downloadStatus != newStatus {
            downloadStatus = newStatus
        }
    }

}

import Foundation
typealias CompletionHandler = ()->Void
typealias ProgressHandler = (String)->Void

class DownloadOperationTask: Operation {
    enum State {
        case ready
        case executing
        case finished
    }

    let url: URL
    let destinationURL: URL
    let binaryIdentifier: String
    var progressHandler: ProgressHandler?
    var completionHandler: CompletionHandler?
    
    override var isAsynchronous: Bool {
        return true
    }
    
    private var _state: State = .ready

    var state: State {
        return _state
    }

    override var isExecuting: Bool {
        return _state == .executing
    }

    override var isFinished: Bool {
        return _state == .finished
    }

    init(url: URL, destinationURL: URL, binaryIdentifier: String, completionHandler: CompletionHandler?, progressHandler: ProgressHandler?) {
        self.completionHandler = completionHandler
        self.progressHandler = progressHandler
        self.url = url
        self.destinationURL = destinationURL
        self.binaryIdentifier = binaryIdentifier
        super.init()
    }

    override func start() {
        if isCancelled {
            finish()
            return
        }

        willChangeValue(forKey: "isExecuting")
        _state = .executing
        didChangeValue(forKey: "isExecuting")

        main()
    }

    override func main() {
        if isCancelled {
            finish()
            return
        }

        // Simulate a download operation
            if isCancelled {
                return
            }
        
        progressHandler?(binaryIdentifier)
            
        Thread.sleep(forTimeInterval: 3.0) // Simulate work

        if isCancelled {
            finish()
            return
        }

        // Save the downloaded file to the destination URL
        // Replace this with your actual file download and save logic

        finish()
    }

    func finish() {
        willChangeValue(forKey: "isExecuting")
        willChangeValue(forKey: "isFinished")
        _state = .finished
        didChangeValue(forKey: "isExecuting")
        didChangeValue(forKey: "isFinished")
        completionHandler?()
    }
}
