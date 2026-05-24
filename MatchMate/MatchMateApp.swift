//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by Priyanka on 23/05/26.
//

import SwiftUI
import CoreData

@main
struct MatchMateApp: App {

    let persistenceController =
        PersistenceController.shared

    var body: some Scene {

        WindowGroup {

            SplashView()
                .environment(
                    \.managedObjectContext,
                    persistenceController
                        .container
                        .viewContext
                )
        }
    }
}
