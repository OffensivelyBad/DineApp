//
//  CheckoutView.swift
//  DineApp
//
//  Created by Shawn Roller on 12/22/19.
//  Copyright © 2019 offensively-bad. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @State private var paymentType = 0
    @State private var tipAmount = 1
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var showingPaymentAlert = false
    @State private var pickupTime = 0
    @EnvironmentObject var order: Order
    
    static let paymentTypes = ["Cash", "Credit Card", "Points"]
    static let tipAmounts = [10, 15, 20, 25, 0]
    static let pickupTimes = ["Now", "Tonight", "Tomorrow Morning"]
    
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total * (Double(Self.tipAmounts[tipAmount]) / 100)
        return total + tipValue
    }
    
    private var formattedFinalTotal: String {
        Self.currencyFormatter.string(from: NSNumber(value: totalPrice)) ?? "--"
    }
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                Toggle(isOn: $addLoyaltyDetails.animation()) {
                    Text("Add loyalty card")
                }
                if addLoyaltyDetails {
                    TextField("Loyalty ID...", text: $loyaltyNumber)
                }
                    
            }
            Section(header: Text("Add a tip?")) {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(0 ..< Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0])%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Pickup time")) {
                Picker("Time:", selection: $pickupTime) {
                    ForEach(0 ..< Self.pickupTimes.count) {
                        Text("\(Self.pickupTimes[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Total: \(formattedFinalTotal)").font(.largeTitle)) {
                Button("Confirm Order") {
                    self.showingPaymentAlert.toggle()
                }
            }
        }
        .navigationBarTitle(Text("Payment"), displayMode: .inline)
        .alert(isPresented: $showingPaymentAlert ) {
            Alert(title: Text("Order confirmed"), message: Text("You total was \(formattedFinalTotal) - thank you!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}
