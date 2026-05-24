//
//  MatchListViewModel.swift
//  MatchMate
//
//  Created by Priyanka on 24/05/26.
//


import Foundation
import Combine

@MainActor
class MatchListViewModel: ObservableObject {

    @Published var users: [User] = []

    @Published var searchText = ""
    
    @Published var isLoading = false

    @Published var errorMessage = ""

    private let apiService = APIService()

    private let coreDataManager =
        CoreDataManager.shared
    
    var filteredUsers: [User] {

        if searchText.isEmpty {

            return users
        }

        return users.filter {

            $0.name.localizedCaseInsensitiveContains(
                searchText
            )
        }
    }
    func fetchUsers() async {

        isLoading = true

        do {

            let apiUsers =
                try await apiService.fetchUsers()

            let cachedUsers =
                coreDataManager.fetchUsers()

            users = apiUsers.map { apiUser in

                if let cachedUser =
                    cachedUsers.first(
                        where: { $0.id == apiUser.id }
                    ) {

                    return User(
                        id: apiUser.id,
                        name: apiUser.name,
                        email: apiUser.email,
                        phone: apiUser.phone,
                        website: apiUser.website,
                        status: cachedUser.status
                    )
                }

                return apiUser
            }

            coreDataManager.saveUsers(users)

        } catch {

            print(
                "API failed. Loading local cache..."
            )

            users = coreDataManager.fetchUsers()

            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    func accept(user: User) {

        if let index =
            users.firstIndex(where: { $0.id == user.id }) {

            users[index].status = .accepted

            coreDataManager.updateStatus(
                userId: user.id,
                status: .accepted
            )
        }
    }

    func decline(user: User) {

        if let index =
            users.firstIndex(where: { $0.id == user.id }) {

            users[index].status = .declined

            coreDataManager.updateStatus(
                userId: user.id,
                status: .declined
            )
        }
    }
}
