//
//  APIService.swift
//  MatchMate
//
//  Created by Priyanka on 24/05/26.
//


import Foundation

class APIService {

    func fetchUsers() async throws -> [User] {

        guard let url = URL(
            string: "https://jsonplaceholder.typicode.com/users"
        ) else {

            throw URLError(.badURL)
        }

        let (data, response) =
            try await URLSession.shared.data(from: url)

        guard let httpResponse =
                response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {

            throw URLError(.badServerResponse)
        }

        let users =
            try JSONDecoder().decode([User].self, from: data)

        return users
    }
}
