//
//  View+Extensions.swift
//  InstaProfileSwiftUI
//
//  Created by Nirajan Shrestha on 30/09/2023.
//

import SwiftUI

struct HeightPreferenceKey : PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct WidthPreferenceKey : PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
    
}

struct SizePreferenceKey : PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    func readWidth(perform action: @escaping (CGFloat) -> Void) -> some View {
        background(GeometryReader {
            Color.clear.preference(key: WidthPreferenceKey.self, value: $0.size.width)
        })
        .onPreferenceChange(WidthPreferenceKey.self, perform: action)
    }
    
    func readHeight(perform action: @escaping (CGFloat) -> Void) -> some View {
        background(GeometryReader {
            Color.clear.preference(key: HeightPreferenceKey.self, value: $0.size.height)
        })
        .onPreferenceChange(HeightPreferenceKey.self, perform: action)
    }
    
    func readSize(perform action: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader {
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: $0.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: action)
    }
}
