//
//  SignUpView.swift
//  ToDoList
//
//  Created by ddudkin on 15.3.25..
//

import SwiftUI
import AuthenticationServices

struct SignUpView: View {
    private enum FocusableField: Hashable {
        case email
        case password
        case confirmPassword
    }
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "checkmark.square")
                    .resizable()
                    .frame(width: 32, height: 32)
                
                Text("ToDo List")
                    .font(.title)
                    .bold()
            }
            .padding(.horizontal)
            
            VStack {
                Image(colorScheme == .light ? "auth-hero-light" : "auth-hero-dark")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                    .padding(.vertical, 24)
                
                
                Text("Get your work done. Make it so.")
                    .font(.title2)
                    .padding(.bottom, 16)
            }
            
            Spacer()
            
            GoogleSignInButton {
                
            }
            
            SignInWithAppleButton { request in
                viewModel.handleSignInWithAppleRequest(request)
            } onCompletion: { result in
                Task {
                    if await viewModel.handleSignInWithAppleCompletion(result) {
                        dismiss()
                    }
                }
            }
            .signInWithAppleButtonStyle(colorScheme == .light ? .black : .white)
            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .cornerRadius(8)
            
            Button(action: {
                withAnimation {
                    viewModel.isOtherAuthOptionsVisible.toggle()
                }
            }) {
                Text("More sign-in options")
                    .underline()
            }
            .buttonStyle(.plain)
            .padding(.top, 16)
            
            if viewModel.isOtherAuthOptionsVisible {
                emailPasswordSignInArea
            }
            
            HStack {
                Text("Already have an account?")
                Button(action: {
                    
                }) {
                    Text("Log in")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 8)
        }
        .padding()
    }
    
    var emailPasswordSignInArea: some View {
        VStack {
            HStack {
                Image(systemName: "at")
                TextField("Email", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($focus, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        self.focus = .password
                    }
            }
            .padding(.vertical, 6)
            .background(Divider(), alignment: .bottom)
            .padding(.bottom, 4)
            
            HStack {
                Image(systemName: "lock")
                SecureField("Password", text: $viewModel.password)
                    .focused($focus, equals: .password)
                    .submitLabel(.go)
                    .onSubmit {
                        // sign up with email and password
                    }
            }
            .padding(.vertical, 6)
            .background(Divider(), alignment: .bottom)
            .padding(.bottom, 8)
            
            HStack {
                Image(systemName: "lock")
                SecureField("Confirm password", text: $viewModel.confirmPassword)
                    .focused($focus, equals: .confirmPassword)
                    .submitLabel(.go)
                    .onSubmit {
                        // sign up with email and password
                    }
            }
            .padding(.vertical, 6)
            .background(Divider(), alignment: .bottom)
            .padding(.bottom, 8)
            
            Button(action: { /* sign up with email and password */ }) {
                if viewModel.authenticationState != .authenticating {
                    Text("Sign up")
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                }
                else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                }
            }
            .disabled(!viewModel.isValid)
            .frame(maxWidth: .infinity)
            //        .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthenticationViewModel())
}
