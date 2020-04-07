//
//  ContentView.swift
//  SwiftUI-Alerts
//
//  Created by Ben Scheirman on 4/6/20.
//  Copyright © 2020 NSScreencast. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    struct RequestError : Identifiable {
        let id: UUID = UUID()
        let message: String
    }

    @State var isShowingConfirmation = false
    @State var hasAgreed = false
    @State var requestError: RequestError?

    var body: some View {
        Group {
            if !hasAgreed {
                showTerms()
            } else {
                VStack {
                    Text("Welcome")
                    .onAppear(perform: {
                        self.fetchData()
                    })
                    .alert(item: $requestError) { requestError in
                        Alert(
                            title: Text("Error"),
                            message: Text(requestError.message),
                            primaryButton: .default(Text("Retry"), action: {
                                self.fetchData()
                            }),
                            secondaryButton: .cancel()
                        )
                    }

                }.padding(20)
            }
        }
    }

    private func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.requestError = RequestError(message: "Unable to load data.")
        }
    }

    private func showTerms() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Terms").font(.largeTitle)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum").font(.body)

            Button(action: {
                self.isShowingConfirmation = true
            }) {
                Text("Continue")
            }
            .alert(isPresented: $isShowingConfirmation) {
                Alert(title: Text("You must agree to the terms to continue."),
                      message: Text("Do you agree?"),
                      primaryButton: .default(Text("Agree"), action: {
                        self.hasAgreed = true
                      }),
                      secondaryButton: .cancel(Text("No"))
                )
            }
        }.padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
