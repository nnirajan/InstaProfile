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

struct SafeAreaInsetsKey: PreferenceKey {
    static var defaultValue = EdgeInsets()
    static func reduce(value: inout EdgeInsets, nextValue: () -> EdgeInsets) {}
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
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
    
    func getSafeAreaInsets(perform action: @escaping (EdgeInsets) -> Void) -> some View {
        background(
            GeometryReader {
                Color.clear
                    .preference(key: SafeAreaInsetsKey.self, value: $0.safeAreaInsets)
            }
        )
        .onPreferenceChange(SafeAreaInsetsKey.self, perform: action)
    }
    
    func readScrollPosition(perform action: @escaping (CGPoint) -> Void) -> some View {
        background(
            GeometryReader {
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: $0.frame(in: .global).origin)
            }
        )
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: action)
    }
}



extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}

private struct SafeAreaInsetsEnvironmentKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUIInsets ?? EdgeInsets()
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsEnvironmentKey.self]
    }
}

private extension UIEdgeInsets {
    var swiftUIInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
