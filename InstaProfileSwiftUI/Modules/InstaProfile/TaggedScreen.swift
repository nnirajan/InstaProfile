//
//  TaggedScreen.swift
//  InstaProfileSwiftUI
//
//  Created by Nirajan Shrestha on 30/09/2023.
//

import SwiftUI

struct TaggedScreen: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(0...100, id: \.self) { index in
                    Text("ram \(index)")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(.red)
                }
            }
        }
    }
}

struct TaggedScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaggedScreen()
    }
}
