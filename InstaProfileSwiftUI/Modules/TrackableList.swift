//
//  TrackableList.swift
//  InstaProfileSwiftUI
//
//  Created by Nirajan Shrestha on 30/09/2023.
//

import SwiftUI

struct TrackableListView<Content: View>: View {
    let offsetChanged: (CGPoint) -> Void
    let content: Content
    
    init(offsetChanged: @escaping (CGPoint) -> Void = { _ in }, @ViewBuilder content: () -> Content) {
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    var body: some View {
        List {
            GeometryReader { geometry in
                Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("ListView")).origin)
            }
            .frame(width: 0, height: 0)
            
            content
                .offset(y: -10)
        }
        .coordinateSpace(name: "ListView")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
        .listStyle(.plain)
    }
}

//private struct ScrollOffsetPreferenceKey: PreferenceKey {
//    static var defaultValue: CGPoint = .zero
//    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
//}
