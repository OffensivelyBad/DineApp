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
    
    @State private var isOrdered = false
    @EnvironmentObject var order: Order
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
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
