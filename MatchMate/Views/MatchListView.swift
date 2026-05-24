//
//  MatchListView.swift
//  MatchMate
//
//  Created by Priyanka on 24/05/26.
//


import SwiftUI

struct MatchListView: View {

    @StateObject private var viewModel = MatchListViewModel()

    var body: some View {
        
        NavigationStack {

            ScrollView {

                LazyVStack(spacing: 6) {

                    if viewModel.isLoading {

                        ProgressView()
                            .padding(.top, 50)

                    } else if viewModel.filteredUsers.isEmpty {

                        VStack(spacing: 12) {

                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 48))
                                .foregroundColor(.gray)

                            Text("No profiles found")
                                .font(.title3)
                                .fontWeight(.semibold)

                            Text(
                                "Try searching with another name"
                            )
                            .foregroundColor(.gray)
                        }
                        .padding(.top, 80)

                    } else {

                        ForEach(viewModel.filteredUsers) { user in

                            MatchCardView(
                                user: user,
                                onAccept: {

                                    viewModel.accept(user: user)
                                },
                                onDecline: {

                                    viewModel.decline(user: user)
                                }
                            )
                        }
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("MatchMate")
            .searchable(
                text: $viewModel.searchText,
                prompt: "Search profiles"
            )
        }
        .task {

            await viewModel.fetchUsers()
        }
    }
}

#Preview {

    MatchListView()
}
