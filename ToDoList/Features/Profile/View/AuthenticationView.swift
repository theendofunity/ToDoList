//
//  AuthenticationView.swift
//  ToDoList
//
//  Created by ddudkin on 12.3.25..
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.flow {
            case .login:
                LoginView()
                    .environmentObject(viewModel)
            case .signUp:
                SignUpView()
                    .environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
