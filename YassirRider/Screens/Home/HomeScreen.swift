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

struct HomeScreen: View {
    
    @StateObject private var model = Model()
    
    @ObservedObject var rider: Rider
    var tripRequestId: ObjectId?
    @State var isShowingTripFlowSheet: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                Mapview(currentMarker: model.currentMarker, markers: model.markersList)
                    .overlay {
                        VStack(alignment:.trailing) {
                            Spacer()
                            HStack {
                                Spacer()
                                CircleButton(image: Image(systemName: "dot.scope"), tint: Color.black) {
                                    model.updateCurrentPosition()
                                }
                                .padding(16)
                            }
                        }
                    }
                ZStack {
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
                        
                        
                        Text("\(rider.fullname)")
                        
                                                
                    }.padding(.horizontal, 14)
                     .padding(.vertical, 20)
                     .padding(.bottom,30)

                }
                .sheet(isPresented: $isShowingTripFlowSheet, content: {
                    if let tripReqId = tripRequestId {
                        TripFlowScreen(tripRequestId: tripReqId)
                            .environment(\.realm, RealmManager.shared.realm!)
                            .padding(.horizontal,8)
                            .padding(.vertical, 0)
                            .transition(.move(edge: .bottom))
                            .presentationDetents([.fraction(0.6)])
                            .interactiveDismissDisabled(true)
                    }
                })
            }.ignoresSafeArea()
        }
            
    }
}

//#Preview {
//    HomeScreen( rider: Rider(id: "RTYUJ", fullname: "youcef"))
//}
