//
//  ContentView.swift
//  InstaProfileSwiftUI
//
//  Created by Nirajan Shrestha on 30/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var contentOffset = CGFloat(0)
    @State private var offsetPositionValue: CGFloat = 0
    
    @State private var isShyHeaderVisible = false
    
    var body: some View {
        NavigationView {
            ZStack {
                TrackableListView { offset in
                    withAnimation {
                        contentOffset = offset.y
                    }
                } content: {
                    Text("\(contentOffset)")
                    
                    Text("\(contentOffset)")
                    
                    Text("\(contentOffset)")
                }
                .overlay(
                    ZStack {
                        HStack {
                            Text("Total points")
                                .foregroundColor(.white)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            Text("20,000 pts")
                                .foregroundColor(.white)
                                .padding(.leading, 50)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .frame(width: UIScreen.main.bounds.width)
                        .background(Color.green)
                        .offset(y: contentOffset < 50 ? 0 : -5)
                        .opacity(contentOffset < 50 ? 1 : 0)
                        .transition(.move(edge: .top))
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                )
            }
            .navigationTitle("Hello")
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxHeight: .infinity, alignment: .top)
//            .background(AccountBackground())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
