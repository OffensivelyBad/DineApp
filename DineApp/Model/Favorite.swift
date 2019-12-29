//
//  Favorite.swift
//  DineApp
//
//  Created by Shawn Roller on 12/27/19.
//  Copyright © 2019 offensively-bad. All rights reserved.
//

import SwiftUI

class Favorite: ObservableObject {
    @Published var items = [MenuItem]()

    func add(item: MenuItem) {
        items.append(item)
    }

    func remove(item: MenuItem) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    func isFavorite(item: MenuItem) -> Bool {
        return self.items.contains(item)
    }
}
