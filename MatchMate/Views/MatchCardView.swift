//
//  MatchCardView.swift
//  MatchMate
//
//  Created by Priyanka on 24/05/26.
//


import SwiftUI

import SwiftUI

struct MatchCardView: View {

    let user: User

    let onAccept: () -> Void
    let onDecline: () -> Void

    var body: some View {

        VStack(spacing: 0) {

            ZStack(alignment: .bottomLeading) {

                AsyncImage(
                    url: URL(
                        string:
                        "https://i.pravatar.cc/500?img=\(user.id)"
                    )
                ) { image in

                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)

                } placeholder: {

                    ProgressView()
                }
                .frame(height: 340)
                .frame(maxWidth: .infinity)
                .clipped()

                LinearGradient(
                    colors: [
                        .clear,
                        .black.opacity(0.7)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack(alignment: .leading, spacing: 6) {

                    Text(user.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    HStack {

                        Label(
                            "Premium",
                            systemImage: "star.fill"
                        )
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.white.opacity(0.2))
                        .foregroundColor(.white)
                        .clipShape(Capsule())

                        Label(
                            "Verified",
                            systemImage: "checkmark.seal.fill"
                        )
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    }
                }
                .padding()
            }

            VStack(alignment: .leading, spacing: 14) {

                HStack(spacing: 12) {

                    Image(systemName: "envelope.fill")
                        .foregroundColor(.pink)

                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                HStack(spacing: 12) {

                    Image(systemName: "phone.fill")
                        .foregroundColor(.blue)

                    Text(user.phone)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                HStack(spacing: 12) {

                    Image(systemName: "globe")
                        .foregroundColor(.purple)

                    Text(user.website)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Divider()

                if user.status == .none {

                    HStack(spacing: 16) {

                        Button {

                            onDecline()

                        } label: {

                            HStack {

                                Image(systemName: "xmark")

                                Text("Decline")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.15))
                            .foregroundColor(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }

                        Button {

                            onAccept()

                        } label: {

                            HStack {

                                Image(systemName: "heart.fill")

                                Text("Accept")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }

                } else {

                    HStack {

                        Spacer()

                        Label(
                            user.status == .accepted
                            ? "Match Accepted"
                            : "Match Declined",
                            systemImage:
                                user.status == .accepted
                                ? "heart.fill"
                                : "xmark.circle.fill"
                        )
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            user.status == .accepted
                            ? Color.green.opacity(0.15)
                            : Color.red.opacity(0.15)
                        )
                        .foregroundColor(
                            user.status == .accepted
                            ? .green
                            : .red
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 16
                            )
                        )

                        Spacer()
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(
            color: .black.opacity(0.12),
            radius: 12,
            x: 0,
            y: 6
        )
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

#Preview {

    MatchCardView(
        user: User(
            id: 1,
            name: "Priyanka Sharma",
            email: "priyanka@gmail.com",
            phone: "+91 9876543210",
            website: "matchmate.com"
        ),
        onAccept: {},
        onDecline: {}
    )
}
