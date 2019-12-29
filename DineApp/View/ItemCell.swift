//
//  ItemCell.swift
//  DineApp
//
//  Created by Shawn Roller on 12/27/19.
//  Copyright © 2019 offensively-bad. All rights reserved.
//

import SwiftUI

struct ItemCell: View {
    var item: MenuItem
    
    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
            Text("$\(item.price)")
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(item: MenuItem.example)
    }
}
