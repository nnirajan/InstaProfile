//
//  InstaHeaderView.swift
//  InstaProfileSwiftUI
//
//  Created by Nirajan Shrestha on 30/09/2023.
//

import SwiftUI

struct InstaHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .frame(width: 80, height: 80)
                
                VStack {
                    Text("40")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Post")
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("290")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Followers")
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("300")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Followings")
                }
                .frame(maxWidth: .infinity)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Nirajan Shrestha")
            }
        }
        .padding()
    }
}

struct InstaHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        InstaHeaderView()
    }
}
