//
//  ContentView.swift
//  Queue
//
//  Created by Marcello Morellato on 28/10/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            Button("Download") {
                viewModel.startDownloads()
            }
            
            Button("Increase priority") {
                viewModel.increasePriority(binaryIdentifier: "50")
            }
            
            Text("\(viewModel.progressStatus)")
            
            Text("\(viewModel.downloadStatus)")
        }
        .onReceive(viewModel.$downloadStatus) { newStatus in
            // Update the view whenever downloadStatus changes
            print("Download Status Updated: \(newStatus)")
        }
    }
}

#Preview {
    ContentView()
}
