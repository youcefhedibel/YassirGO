//
//  LoginView.swift
//  GoRider
//
//  Created by Mac on 03/03/2024.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject private var model = Model()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var fullName: String = ""
    @State private var confirmPassword: String = ""
    @State private var isSignup: Bool = false
    
    private var isDisabledButton: Bool {
        if isSignup {
            return (email.isEmpty || password.isEmpty || fullName.isEmpty || confirmPassword.isEmpty)
        } else {
            return (email.isEmpty || password.isEmpty)
        }
    }
    
    var body: some View {

            VStack(alignment: .leading, spacing: 12){
                VStack(alignment: .leading){
                    Text("Log in or create an account")
                        .font(.primaryText, .regular, 17)
                    Text("Login to yassir Go")
                        .font(.primaryText, .extraBold, 26)
                    Text("You will receive a text message with your verification code. ")
                        .font(.primaryText, .regular, 14)
                }.padding(.top, 50)
                Spacer()
                VStack(spacing: 22) {
                    HStack(alignment: .center) {
                        Text(isSignup ?"Create account" : "sign in").font(.primaryText, .extraBold, 24)
                    }
                    if isSignup {
                        TextField("full name", text: $fullName)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primaryText, lineWidth: 1.2)
                            }
                    }
                    TextField("email", text: $email)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.primaryText, lineWidth: 1.2)
                        }
                    SecureField("password", text: $password)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.primaryText, lineWidth: 1.2)
                        }
                    if isSignup {
                        SecureField("confirm password", text: $confirmPassword)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primaryText, lineWidth: 1.2)
                            }
                    }
                    
                    YassirButton(disabled: isDisabledButton, radius: 10) {
                        if model.isLoading {
                            ProgressView()
                        } else {
                            Text(isSignup ? "sign up" : "connect").font(isDisabledButton ? .gray : .white, .bold, 20)

                        }
                    } action: {
                        if isSignup {
                            model.signup(fullname: fullName, email: email, password: password)
                        } else {
                            model.login(email: email, password: password)
                        }
                    }
                    
                    if isSignup {
                        HStack(alignment: .top) {
                            Text("You have an account ?").font(.primaryText, .regular, 16)
                            Button (action: {
                                email = ""
                                password = ""
                                isSignup = false
                            }){
                                Text("Login now").font(.blue, .regular, 16)
                            }
                            Spacer()
                        }

                    } else {
                        HStack(alignment: .top) {
                            Text("Don't have an account ?").font(.primaryText, .regular, 16)
                            Button (action: {
                                email = ""
                                password = ""
                                isSignup = true
                            }){
                                Text("Create now").font(.blue, .regular, 16)
                            }
                            Spacer()
                        }
                    }

                }.padding()
                
            }//.padding(.top, insets.top)
                .padding(.horizontal, 16)

    }
}

#Preview {
    LoginScreen()
}
