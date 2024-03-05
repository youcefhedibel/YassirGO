//
//  LoginScreenModel.swift
//  YassirRider
//
//  Created by Mac on 05/03/2024.
//

import Foundation

extension LoginScreen {
    class Model: ObservableObject {
        @Published var isLoading: Bool = false
        
        @MainActor
        func login(email: String, password: String) {
            self.isLoading = true
            Task {
                do {
                    try await RealmManager.shared.login(email: email,password: password)
                }  catch {
                    self.isLoading = false
                    print("username or password incorrect")
                }
            }
        }
        
        @MainActor
        func signup(fullname: String, email: String, password: String) {
            self.isLoading = true
            Task {
                do {
                    try await RealmManager.shared.signUp(fullname: fullname, email: email, password: password)
                    
                } catch {
                    print("failed to sign up")
                    isLoading = false
                }
            }
        }
        
    }
}
