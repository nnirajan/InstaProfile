//
//  InstaStoryView.swift
//  InstaProfileSwiftUI
//
//  Created by Nirajan Shrestha on 30/09/2023.
//

import SwiftUI

struct InstaStoryView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0...10, id: \.self) { index in
                    VStack {
                        Circle()
                            .frame(width: 70)
                        
                        Text("Pokhara")
                    }
                }
            }
            .padding()
        }
    }
}

struct InstaStoryView_Previews: PreviewProvider {
    static var previews: some View {
        InstaStoryView()
    }
}
