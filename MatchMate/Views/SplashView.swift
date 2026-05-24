//
//  SplashView.swift
//  MatchMate
//
//  Created by Priyanka on 24/05/26.
//

import SwiftUI

struct SplashView: View {

    @State private var isActive = false

    @State private var scale: CGFloat = 0.8

    @State private var opacity = 0.5

    var body: some View {

        if isActive {

            MatchListView()

        } else {

            ZStack {

                LinearGradient(
                    colors: [
                        Color.pink,
                        Color.purple
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {

                    Image("LaunchLogo")

                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 32
                            )
                        )
                        .shadow(radius: 12)

                    Text("MatchMate")

                        .font(.system(size: 38))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .scaleEffect(scale)
                .opacity(opacity)
            }
            .onAppear {

                withAnimation(
                    .easeIn(duration: 1.2)
                ) {

                    self.scale = 1.0
                    self.opacity = 1.0
                }

                DispatchQueue.main.asyncAfter(
                    deadline: .now() + 2
                ) {

                    withAnimation {

                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {

    SplashView()
}
