//
//  CityListRow.swift
//  TaskGroupSwift
//
//  Created by Ayush Gupta on 01/04/24.
//

import SwiftUI

struct CityListRow: View {
    let title: String
    let isSelected: Bool
    let tapAction: () -> Void
    
    var body: some View {
        Button(action: tapAction) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
        }
        .foregroundColor(isSelected ? .blue : .black)
    }
}

struct CityListRow_Previews: PreviewProvider {
    static var previews: some View {
        CityListRow(title: "Pune", isSelected: true, tapAction: {})
    }
}
