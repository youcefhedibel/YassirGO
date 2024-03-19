//
//  ProfileScreen.swift
//  YassirRider
//
//  Created by Mac on 18/03/2024.
//

import SwiftUI
import RealmSwift

struct ProfileScreen: View {
    @State private var fullName = ""
    @State private var phoneNumber = ""
    @State private var id = ""
    @State private var email = ""
    
    @ObservedRealmObject var rider: Rider
    
    @StateObject private var model = Model()
    
    private var disableButton: Bool {
        if (fullName.isEmpty || email.isEmpty) {
            
        }
        return true
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
                
                profileTextFieldItem(text: "Fullname", bindingText: $email)
                
                profileTextFieldItem(text: "Phone Number", bindingText: $phoneNumber)

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
                
                profileTextFieldItem(text: "email", bindingText: $email)
                
            }
            
            Spacer()
            
            YassirButton(disabled: false, radius: 10) {
                HStack {
                    Spacer()
                    Text("Sauvegarder")
                        .font(.white, .medium, 18)
                    Spacer()
                }
            } action: {
                /// TODO: implement save changes to realm
            }

        }.padding(.horizontal, 16)
         .padding(.vertical, 50)
         .edgesIgnoringSafeArea(.all)
        
    }
    
    @ViewBuilder
    private func profileTextFieldItem(text: String, bindingText: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(.secondaryText, .regular, 14)
            TextField(text, text: bindingText)
                .font(Font.system(size: 18, design: .default))
                .padding(10)
                .disableAutocorrection(true)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.secondary, lineWidth: 0.5)
                }
        }

    }
}

#Preview {
    ProfileScreen(rider: Rider(id: "56789", fullname: "Youcef"))
}
