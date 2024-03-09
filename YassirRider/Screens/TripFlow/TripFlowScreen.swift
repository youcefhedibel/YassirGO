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
    var tripRequestId: ObjectId
    var body: some View {
        VStack{
            if let tripStatus = model.trip?.status {
                switch tripStatus {
                case.pending:
                    LottieView(name: "progress-animation", loopMode: .loop)
                        .frame(height: 2)
                    VStack(alignment: .leading) {
                        
                        Text("Looking for a Driver...")
                            .font(.primaryText, .bold, 22)
                        Text("Veuillez patienter un instant, nous contactons le chauffeur le plus proche de vous.")
                            .font(.secondaryText, .regular, 14)
                            .multilineTextAlignment(.leading)
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
                                Text("Sidi Yahia, Said Hamdine")
                                    .font(.primaryText, .regular, 14)
                                    .lineLimit(1)
                                Text("Superette 3M Said Hamdine, Rue des Fleurs...")
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
                            
                            Text("\(model.trip?.price ?? 00) DA")
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
                                // model.cancel trip
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
                default:
                    Text("default")
                }
            }
        }.onAppear {
            model.getTripRequest(id: tripRequestId)
        }


    }
}

#Preview {
    TripFlowScreen(tripRequestId: ObjectId("65e882b7cdf51df5efc5e138"))
}
