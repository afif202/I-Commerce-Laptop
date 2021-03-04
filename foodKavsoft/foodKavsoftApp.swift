//
//  foodKavsoftApp.swift
//  foodKavsoft
//
//  Created by Irianda on 28/02/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

@main
struct foodKavsoftApp: App {
   @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// initializing firebase
class AppDelegate: NSObject,UIApplicationDelegate {
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      return true
   }
}
