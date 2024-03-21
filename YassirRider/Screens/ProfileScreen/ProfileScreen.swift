//
//  ProfileScreen.swift
//  YassirRider
//
//  Created by Mac on 18/03/2024.
//

import SwiftUI
import RealmSwift

struct ProfileScreen: View {
    
    @StateObject private var model = Model()
    
    @ObservedObject var rider: Rider
    
    @State private var fullName = ""
    @State private var phoneNumber = ""
    @State private var id = ""
    @State private var email = ""
    
    private var disableButton: Bool {
        if (self.fullName == rider.fullname && self.phoneNumber == rider.phoneNumber) {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .center) {
                BackButton(text: "", textColor: .white, font: .bold, fontSize: 12)
                Text("Mon profil")
                    .font(.primaryText, .medium, 18)
                Spacer()
            }
            
            HStack {
                Spacer()
                Image("avatar")
                    .resizable()
                    .frame(width: 100, height: 100)
                Spacer()
            }
            
            Text("Informations")
                .font(.secondaryText, .medium, 18)
            
            VStack(alignment: .leading, spacing: 5) {
                
                profileTextFieldItem(text: "Fullname", bindingText: $fullName, disabled:false)
                
                profileTextFieldItem(text: "Phone Number", bindingText: $phoneNumber, disabled: false)
                    .keyboardType(.numberPad)
                
                VStack(alignment: .leading) {
                    Text("ID")
                        .font(.secondaryText, .regular, 14)
                    
                    HStack {
                        TextField("ID", text: $id)
                            .font(Font.system(size: 18, design: .default))
                            .padding(10)
                            .disabled(true)
                            .disableAutocorrection(true)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.secondary, lineWidth: 0.5)
                            }
                        
                        Button {
                            model.copyToClipBoard(text: id)
                        }
                    label: {
                        Image(systemName: "doc.on.doc.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.primaryColor)
                    }
                    }
                }
                
                profileTextFieldItem(text: "email", bindingText: $email, disabled: true)
                
                Button {
                    model.logout()
                } label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .resizable()
                            .frame(width: 20, height: 15)
                            .foregroundColor(.primaryColor)
                            .bold()
                        Text("Loguut")
                            .font(.primaryColor, .medium, 18)
                    }.padding(.top)
                }
                
            }
            
            Spacer()
            
            YassirButton(disabled: disableButton, radius: 10) {
                HStack {
                    Spacer()
                    Text("Sauvegarder")
                        .font(.white, .medium, 18)
                    Spacer()
                }
            } action: {
                if !(self.fullName == rider.fullname) {
                    model.updateProfile(fullName: self.fullName, phone: nil)
                } else {
                    model.updateProfile(fullName: nil, phone: self.phoneNumber)
                }
            }
            
        }.padding(.horizontal, 16)
            .padding(.vertical, 50)
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .onAppear{
                self.fullName = rider.fullname
                self.phoneNumber = rider.phoneNumber
                self.id = app.currentUser?.id ?? ""
                self.email = app.currentUser?.profile.email ?? ""
            }
    }
    
    @ViewBuilder
    private func profileTextFieldItem(text: String, bindingText: Binding<String>, disabled: Bool) -> some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(.secondaryText, .regular, 14)
            TextField(text, text: bindingText)
                .font(Font.system(size: 18, design: .default))
                .padding(10)
                .disableAutocorrection(true)
                .disabled(disabled)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.secondary, lineWidth: 0.5)
                }
        }
        
    }
}

#Preview {
    ProfileScreen(rider: Rider(id: "ZERTYUIKJHG", fullname: "Test"))
}
