//
//  Persistence.swift
//  MatchMate
//
//  Created by Priyanka on 23/05/26.
//

import CoreData

struct PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {

        container = NSPersistentContainer(name: "MatchMate")

        if inMemory {

            container.persistentStoreDescriptions.first?.url =
                URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in

            if let error = error as NSError? {

                fatalError(
                    "Unresolved error \(error), \(error.userInfo)"
                )
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
