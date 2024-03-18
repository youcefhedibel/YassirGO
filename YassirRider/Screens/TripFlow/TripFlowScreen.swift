//
//  TripFlowScreen.swift
//  YassirRider
//
//  Created by Mac on 07/03/2024.
//

import SwiftUI
import RealmSwift

struct TripFlowScreen: View {
    @StateObject private var model = Model()
    @ObservedRealmObject var trip: Trip
    var callBack : (Bool) -> Void 
    var body: some View {
            VStack {
                if trip.status ==  .pending {
                    LottieView(name: "progress-animation", loopMode: .loop)
                        .frame(height: 2)
                }
                    
                        VStack(alignment: .leading) {
                            switch trip.status {
                            case .pending:
                                Text("Looking for a Driver...")
                                    .font(.primaryText, .bold, 22)
                                Text("Veuillez patienter un instant, nous contactons le chauffeur le plus proche de vous.")
                                    .font(.secondaryText, .regular, 14)
                                    .multilineTextAlignment(.leading)
                            case .accepted:
                                acceptedComponent()
                            case .arrivedClient:
                                Text("arrivedDriver")
                            case .toDestination:
                                Text("toDestination")
                            case .arrivedDestination:
                                Text("arrivedDestination")
                            case .toClient:
                                Text("toClient")
                            case .canceled:
                                Text("canceled")
                            case .completed:
                                Text("completed")

                            }

                            Text("Itinéraire")
                                .font(.primaryText, .bold, 16)
                                .padding(.top, 16)
                            HStack(alignment: .top){
                                VStack {
                                    Image("icon-purple-circle")
                                        .resizable()
                                        .frame(width: 14, height: 14)
                                    Rectangle()
                                        .frame(width: 2, height: 20)
                                        .foregroundColor(.gray.opacity(0.7))
                                    Image("icon-dark-circle")
                                        .resizable()
                                        .frame(width: 14, height: 14)
                                    }.padding(.top,2)
                                    
                                VStack(alignment:.leading, spacing:33) {
                                    Text(trip.pickup)
                                        .font(.primaryText, .regular, 14)
                                        .lineLimit(1)
                                    Text(trip.dropOff)
                                        .font(.primaryText, .regular, 14)
                                        .lineLimit(1)
                                    }
                                }
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("Prix").font(.primaryText, .bold, 18)
                                    Spacer()
                                    Image(systemName: "info.circle")
                                        .foregroundColor(.primaryText)
                                        .font(.system(size: 18))
                                }
                                
                                Text("\(trip.price) DA")
                                    .font(.primaryText, .medium, 16)
                                
                                HStack{
                                    Image("icon-currency")
                                        .resizable()
                                        .frame(width: 16, height: 12, alignment: .center)
                                    Text("Paiment en espéce")
                                        .font(.primaryText, .regular, 14)
                                }
                                
                                Text("Options")
                                    .font(.primaryText, .medium, 18)
                                HStack {
                                    Image(systemName: "questionmark.circle")
                                        .foregroundColor(.primaryText)
                                    Text("Besoin d'aide ?")
                                        .font(.primaryText, .regular, 14)
                                }
                                
                                Divider()
                                
                                Button {
                                    callBack(false)
                                    model.cancelTrip(tripID: trip._id)
                                } label: {
                                    HStack {
                                        Image(systemName: "x.circle.fill")
                                            .resizable()
                                            .frame(width: 20, height: 20, alignment: .center)
                                            .foregroundColor(.red)
                                            
                                        Text("Annuler la course")
                                            .font(.red, .regular, 14)
                                            
                                    }
                                   
                                }
                            }.padding(.top, 10)
                        }
                        .padding(20)
                        
                
            }
            .background(.white)
            
    }
    
     @ViewBuilder
    private func acceptedComponent() -> some View {
        Text("Classique")
            .font(.primaryText, .medium, 22)
        HStack(alignment: .top){
            Image("icon-car-classic")
                .resizable()
                .frame(width: 70, height: 40)
                .padding(8)
            VStack(alignment: .leading, spacing: 8){
                Text("Renault Symblole. Grise")
                    .font(.primaryText, .medium, 16)
                Text("12345.116.16")
                    .font(.secondaryText, .regular, 14)
            }
        }
        
        VStack {
            HStack {
                Image("avatar")
                    .resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text("Amine.A")
                        .font(.primaryText, .regular, 16)
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                        Text("4.5")
                            .font(.primaryText, .regular, 14)
                    }
                 
                }
                Spacer()
                
                Button {
                    // TODO:::
                } label: {
                    Image("icon-phone-call")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                
                Button {
                    // TODO:::
                } label: {
                    Image("icon-message")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.lightGreen)
                Text("Partenaire vérifié(e) selon un processus rigoureux")
                    .font(.lightGreen, .regular, 12)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 8.0).foregroundColor(.lightGreen.opacity(0.2))
            }
        }
        .padding(8)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.5), lineWidth: 1))
        
       
    }
}

#Preview {
    TripFlowScreen(trip: Trip(pickup: "Saoula", dropOff: "Cheraga", price: 540, status: .accepted), callBack: { _ in } )
}
