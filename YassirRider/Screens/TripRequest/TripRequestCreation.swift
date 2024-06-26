//
//  TripRequestCreation.swift
//  YassirRider
//
//  Created by Mac on 06/03/2024.
//

import SwiftUI
import RealmSwift

struct TripRequestCreation: View {
    @StateObject private var model = Model()
    @State private  var pickup: String = ""
    @State private  var dropoff: String = ""
    
    private var disableButton: Bool {
        return (pickup.isEmpty || dropoff.isEmpty)
    }
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing:0) {
                HStack(alignment: .top) {
                    VStack(spacing: 5) {
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .bold()
                            .foregroundColor(.primaryColor)
                        Rectangle().frame(width: 1.2, height: 30).foregroundColor(.gray)
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .bold()
                            .foregroundColor(.black)
                    }.padding(.top, 12)
                    
                    VStack {
                        TextField("Cheraga, Cheraga, ALger, Algerie", text: $pickup)
                            .padding(12)
                            .overlay {
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 1.2)
                            }
                        
                        TextField("Choisir une destination", text: $dropoff)
                            .padding(12)
                            .overlay {
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 1.2)
                            }
                    }.padding(.trailing, 22)
                }
                Rectangle()
                    .frame( height: 4)
                    .foregroundColor(.gray.opacity(0.1))
                    .shadow(color: .gray, radius: 5, x: 0, y: 10)
                    .padding()
                Spacer()
                
                NavigationButton(disabled: disableButton, destination: {
                    HomeScreen(rider: RiderRepo.sharedRider.rider!, isShowingTripFlowSheet: true)
                }, label: {
                    HStack {
                        Text("create trip")
                            .font(.white, .bold, 20)
                            .frame(maxWidth: .infinity, maxHeight: 55)
                            .cornerRadius(10)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .fill(disableButton ? Color.disabledButton : Color.primaryColor)
                                .shadow(radius: 0.5))
                        
                    }
                }, action: {
                    model.createTripRequest(pickup: pickup, dropoff: dropoff, price: Int.random(in: 200...1500), status: .pending)
                })
                
            }
            .padding()
            .padding(.top, .heightPer(per: 0.05))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(text: "Personaliser votre  course", textColor: .primaryText, font: .extraBold, fontSize: 18))
        }
    }
}

#Preview {
    TripRequestCreation()
}
