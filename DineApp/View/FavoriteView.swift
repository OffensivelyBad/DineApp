//
//  FavoriteView.swift
//  DineApp
//
//  Created by Shawn Roller on 12/27/19.
//  Copyright © 2019 offensively-bad. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var favorite: Favorite
    
    private func deleteItems(at offsets: IndexSet) {
        favorite.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(favorite.items) { item in
                    ItemRow(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitle("Favorites")
            .listStyle(GroupedListStyle())
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static let favorite = Favorite()
    
    static var previews: some View {
        NavigationView {
            FavoriteView().environmentObject(favorite)
        }
    }
}
