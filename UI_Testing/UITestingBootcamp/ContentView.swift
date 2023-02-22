//
//  ContentView.swift
//  UITestingBootcamp
//
//  Created by Ahmed Ali on 21/02/2023.
//

import SwiftUI

class UITestingBootcampViewModel: ObservableObject {
    @Published var textField = ""
    @Published var isCurrentUserSignedIn = false
    let placeholder = "Add your name"
    
    func signUpBtnPressed() {
        guard !textField.isEmpty else { return }
        isCurrentUserSignedIn = true
    }
}

struct ContentView: View {
    @StateObject private var vm = UITestingBootcampViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if vm.isCurrentUserSignedIn {
                SignedInHomeView()
            } else {
                signupLayer
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension ContentView {
    var signupLayer: some View {
        VStack {
            TextField(vm.placeholder, text: $vm.textField)
                .font(.headline)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .accessibilityIdentifier("SignUpTextField")
            
            Button {
                vm.signUpBtnPressed()
            } label: {
                Text("Sign up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .accessibilityIdentifier("SignUpButton")
            }
            
        }
        .padding()
    }
}

struct SignedInHomeView: View {
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Show welcome alert!")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("WelcomeAlertButton")
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Welcome to the app!"))
                }
                
                NavigationLink(destination: Text("Destination")) {
                    Text("Navigate")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Welcome")
        }
        .navigationViewStyle(.stack)
    }
}
