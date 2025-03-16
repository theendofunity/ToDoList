//
//  GoogleSignInButton.swift
//  ToDoList
//
//  Created by ddudkin on 15.3.25..
//

import SwiftUI

import SwiftUI

enum GoogleSignInButtonLabel: String {
  case signIn = "Sign in with Google"
  case `continue` = "Continue with Google"
  case signUp = "Sign up with Google"
}

struct GoogleSignInButton: View {
  @Environment(\.colorScheme)
  private var colorScheme

  var label = GoogleSignInButtonLabel.continue
  var action: () -> Void

  init(_ label: GoogleSignInButtonLabel = .continue, action: @escaping () -> Void) {
    self.label = label
    self.action = action
  }

  var body: some View {
    Button(action: action) {
      HStack(spacing: 2) {
        Image("Google")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 20, alignment: .center)
        Text(label.rawValue)
          .bold()
          .padding(.vertical, 8)
      }
      .frame(maxWidth: .infinity)
    }
    .foregroundColor(colorScheme == .dark ? .black : .white)
    .background(colorScheme == .dark ? .white : .black)
    .cornerRadius(8)
    .buttonStyle(.bordered)
  }
}

#Preview {
    GoogleSignInButton {
        
    }
}
