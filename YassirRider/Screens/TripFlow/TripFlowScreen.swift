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
    
    @State private var  driverRating: Int = 3
    
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
                    tripInfo()
                case .accepted:
                    acceptedComponent()
                    tripInfo()
                case .toClient:
                    tripStateText(text: "Votre  chauffeur est  en route")
                    tripInfo()
                case .arrivedClient:
                    tripStateText(text: "Votre chauffeur est  arrivé")
                    tripInfo()
                case .toDestination:
                    tripStateText(text: "En route vers la distination")

                    tripInfo()
                case .arrivedDestination:
                    arrivedToDestination()
                case .completed:
                    completedTrip()
                case .canceled:
                    Text("canceled")
                    
                }
                Spacer().frame(height: CGFloat.heightPer(per: 0.02))
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
    
    @ViewBuilder
    private func completedTrip() -> some View {
        VStack(spacing: 20) {
            Text("Notez votre YASSIR")
                .font(.primaryText, .regular, 16)
            Image("user-avatar")
                .resizable()
                .frame(width: 60, height: 60)
            Text(DriverRepo.sharedDriver.driver?.fullname ?? "test user")
                .font(.primaryText, .regular, 18)
            
            RatingView(rating: $driverRating)
            
            YassirButton(radius: 10) {
                HStack{
                    Spacer()
                    Text("Envoyer").font(.white, .medium, 18)
                    Spacer()
                }.padding(12)
                
            } action: {
                model.rateDriver(stars: driverRating)
                callBack(false)
            }
            .padding(.top, 20)
            
            Spacer().frame(height: CGFloat.heightPer(per: 0.03))
            
        }
    }
    
    @ViewBuilder
    private func tripInfo() -> some View {
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
    
    @ViewBuilder
    func tripStateText(text: String) -> some View {
        HStack {
            Image("icon-home")
                .resizable()
                .frame(width: 30, height: 30)
            Spacer()
            Text(text)
                .font(.primaryText, .medium, 18)
            Spacer()
        }
        .padding(8)
        
    }
    
    @ViewBuilder
    private func arrivedToDestination() -> some View {
        VStack(spacing: 12) {
            Image("icon-flag")
                .resizable()
                .frame(width: 70, height: 70)
            Text(trip.dropOff)
                .font(.primaryText, .semiBold, 18)
            Text("Vous etes arrivé")
                .font(.secondaryText, .regular, 16)
            HStack{
                Text("Prix de la course")
                    .font(.primaryText, .regular, 16)
                Spacer()
                Text("\(trip.price)")
                    .font(.primaryText, .regular, 16)
            }.padding(12)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondaryText.opacity(0.15), lineWidth: 1))
            
            YassirButton(radius: 10) {
                HStack{
                    Spacer()
                    Text("Confirm").font(.white, .medium, 18)
                    Spacer()
                }.padding(12)
                
            } action: {
                model.completeTrip(tripID: trip._id)
            }
            .padding(.top, 20)
            
            Spacer().frame(height: CGFloat.heightPer(per: 0.03))
        }
    }
    

    
}

#Preview {
    TripFlowScreen(trip: Trip(pickup: "Saoula", dropOff: "Bab el ooued, Alger centre", price: 540, status: .toDestination), callBack: { _ in } )
}
