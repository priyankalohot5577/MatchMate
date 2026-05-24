//
//  CoreDataManager.swift
//  MatchMate
//
//  Created by Priyanka on 24/05/26.
//


import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    private let context =
        PersistenceController.shared.container.viewContext

    // MARK: - Save Users

    func saveUsers(_ users: [User]) {

        clearUsers()

        for user in users {

            let entity = MatchEntity(context: context)

            entity.id = Int64(user.id)
            entity.name = user.name
            entity.email = user.email
            entity.phone = user.phone
            entity.website = user.website
            entity.status = user.status.rawValue
        }

        do {

            try context.save()
            print("Users saved successfully")

        } catch {

            print(error.localizedDescription)
        }
    }

    // MARK: - Fetch Users

    func fetchUsers() -> [User] {

        let request: NSFetchRequest<MatchEntity> =
            MatchEntity.fetchRequest()

        do {

            let results = try context.fetch(request)

            print("Fetched users count: \(results.count)")

            return results.map {

                User(
                    id: Int($0.id),
                    name: $0.name ?? "",
                    email: $0.email ?? "",
                    phone: $0.phone ?? "",
                    website: $0.website ?? "",
                    status: MatchStatus(
                        rawValue: $0.status ?? ""
                    ) ?? .none
                )
            }

        } catch {

            print(error.localizedDescription)

            return []
        }
    }

    // MARK: - Update Status

    func updateStatus(
        userId: Int,
        status: MatchStatus
    ) {

        let request: NSFetchRequest<MatchEntity> =
            MatchEntity.fetchRequest()

        request.predicate =
            NSPredicate(
                format: "id == %d",
                userId
            )

        do {

            let results =
                try context.fetch(request)

            if let user = results.first {

                user.status = status.rawValue

                try context.save()
            }

        } catch {

            print(error.localizedDescription)
        }
    }

    // MARK: - Clear Old Cache

    private func clearUsers() {

        let request: NSFetchRequest<NSFetchRequestResult> =
            MatchEntity.fetchRequest()

        let deleteRequest =
            NSBatchDeleteRequest(fetchRequest: request)

        do {

            try context.execute(deleteRequest)

        } catch {

            print(error.localizedDescription)
        }
    }
}
