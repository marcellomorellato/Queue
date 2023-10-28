# Queue App

The **Queue app** is a simple iOS application that demonstrates the use of OperationQueue to manage concurrent download tasks with adjustable priorities.

## Technologies Used

- **Swift**: The primary programming language.
- **SwiftUI**: Utilized for creating the user interface.
- **OperationQueue**: Responsible for managing concurrent download operations.
- **Foundation**: Employed for URL handling, file operations, and asynchronous tasks.
- **ObservableObject and Published**: SwiftUI features for creating a reactive user interface.

## App Functionality

- **Download Queue**: Manages download operations, with the option to adjust concurrent limits.
- **Start Downloads**: Initiates 100 simulated download tasks with progress updates.
- **Increase Priority**: Allows elevating the priority of a specific download task.
- **Progress Updates**: Provides real-time feedback on the current download task.
- **Download Status**: Displays the total number of download tasks.
- **Reactive UI**: The SwiftUI framework updates the user interface as properties change.

## How it Works

1. Click "Download" to initiate 100 download tasks, each with a 3-second simulated delay.
2. Utilize "Increase priority" to prioritize a specific download task.
3. The app continually updates progress and download status.
4. Demonstrates the use of OperationQueue for task management and priority control.

## Building and Running

To run the app, open the project in Xcode and select a target device or simulator. This allows you to build and run the app, providing a hands-on experience with OperationQueue for task and priority management in iOS projects.

