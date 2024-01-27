//
//  PostedScreen.swift
//  InstaProfileSwiftUI
//
//  Created by Nirajan Shrestha on 30/09/2023.
//

import SwiftUI

struct PostedScreen: View {
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0...10, id: \.self) { index in
                Text("ram \(index)")
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(.red)
            }
        }
    }
}

struct PostedScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            PostedScreen()
        }
    }
}
