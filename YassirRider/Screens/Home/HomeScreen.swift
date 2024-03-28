//
//  HomeScreen.swift
//  GoRider
//
//  Created by Mac on 02/03/2024.
//

import SwiftUI
import GoogleMaps
import Foundation
import RealmSwift
import BottomSheetUI

struct HomeScreen: View {
    
    @StateObject private var model = Model()
    
    @ObservedObject var rider: Rider
    
    @ObservedRealmObject var trip = (TripRepo.sharedTrip.trip ?? Trip())

        
    @State var isShowingTripFlowSheet: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom) {
                Mapview(currentMarker: model.currentMarker, markers: model.markersList)
                ZStack {
                    VStack {
                        HStack {
                            switch trip.status {
                            case .toClient:
                                tripStateText(text: "Votre  chauffeur est  en route")
                            case .arrivedClient:
                                tripStateText(text: "Votre chauffeur est  arrivé")
                            case .toDestination:
                                tripStateText(text: "En route vers la distination")
                                
                            default: EmptyView()
                            }
                            Spacer()
                            NavigationLink {
                                ProfileScreen(rider: rider)
                            } label: {
                                ZStack {
                                    Image("avatar")
                                        .resizable()
                                        .frame(width: 47, height: 47, alignment: .center)
                                }
                                .frame(width: 50, height: 50)
                                .background(Circle().fill(.white).shadow(color: .black.opacity(0.1), radius: 5))
                                .padding(16)
                            }
                            
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            CircleButton(image: Image(systemName: "dot.scope"), tint: Color.black) {
                                model.updateCurrentPosition()
                            }.padding(16)
                        }
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Besoin d'un chauffeur ou d'un service de livraison?").font(.primaryText, .extraBold, 20)
                            Text("Indiquez votre destination en cliquant sur la barre en  bas").font(.primaryText, .medium, 14)
                            
                            NavigationLink {
                                TripRequestCreation()
                            } label: {
                                HStack{
                                    Image(systemName: "circle")
                                        .font(.system(size: 18))
                                        .foregroundColor(.primaryText)
                                    Text("Destination").font(.primaryText, .medium, 16)
                                    Spacer()
                                    Image(systemName: "arrowtriangle.right.fill")
                                        .resizable()
                                        .frame(width: 8, height: 12)
                                        .font(.system(size: 16))
                                        .foregroundColor(.primaryColor)
                                }
                                .padding(14)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.primaryText, lineWidth: 1.2)
                                              }
                                          }
                                          
                                          Text("user: \(rider.fullname)")
                                              .font(.primaryText, .semiBold, 14)
                            
                        }.padding(.horizontal, 14)
                            .padding(.vertical, 20)
                            .padding(.bottom,30)
                            .background(Color.white)
                        
                        
                    }.padding(.top, CGFloat.heightPer(per: 0.06))
                }
                .asBottomSheetUI(
                    show: $isShowingTripFlowSheet,
                    content: {
                        TripFlowScreen(trip: TripRepo.sharedTrip.trip ?? Trip()) { showSheet in isShowingTripFlowSheet = showSheet }
                    }
                )
                
            }.ignoresSafeArea()
             .navigationBarBackButtonHidden(true)
             .onAppear {
                 isShowingTripFlowSheet = model.checkIsOnTrip()
             }
        }
    }
    
    @ViewBuilder
    func tripStateText(text: String) -> some View {
        HStack {
            Image("icon-home")
                .resizable()
                .frame(width: 30, height: 30)
            Spacer()
            Text(text)
                .font(.primaryText, .regular, 12)
            Spacer()
        }
        .padding(8)
        .background(.white)
        .cornerRadius(16)
        .padding(8)
        
    }
}

#Preview {
    HomeScreen( rider: Rider(id: "RTYUJ", fullname: "youcef"))
}

