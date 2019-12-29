//
//  ItemDetail.swift
//  DineApp
//
//  Created by Shawn Roller on 12/22/19.
//  Copyright © 2019 offensively-bad. All rights reserved.
//

import SwiftUI

struct ItemDetail: View {
    var item: MenuItem
    
    @EnvironmentObject var order: Order
    @EnvironmentObject var favorite: Favorite
    @State private var isOrdered = false
    
    private func getFavoriteImage() -> String {
        return favorite.isFavorite(item: item) ? "star.fill" : "star"
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                ZStack(alignment: .topTrailing) {
                    Image(item.mainImage)
                    Button(action: {
                        if self.favorite.isFavorite(item: self.item) {
                            self.favorite.remove(item: self.item)
                        } else {
                            self.favorite.add(item: self.item)
                        }
                    }) {
                        Image(systemName: getFavoriteImage())
                            .padding(5)
                            .foregroundColor(.yellow)
                            .font(.headline)
                            .foregroundColor(.red)
                            .offset(x: -5, y: 5)
                    }
                }
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .foregroundColor(.white)
                    .font(.caption)
                    .background(Color.black)
                    .offset(x: -5, y: -5)
            }
            Text(item.description)
                .padding()
            Button(isOrdered ? "Ordered!" : "Order this") {
                self.order.add(item: self.item)
                self.isOrdered = true
            }
            .disabled(isOrdered)
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            .foregroundColor(.white)
            .font(Font.system(.headline, design: .default))
            .background(Color.blue)
            .cornerRadius(3)
            .shadow(radius: 2)
            Spacer()
        }
        .navigationBarTitle(Text(item.name), displayMode: .inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        NavigationView {
            ItemDetail(item: MenuItem.example).environmentObject(order)
        }
    }
}
