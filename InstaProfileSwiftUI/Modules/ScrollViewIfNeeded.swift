//
//  ScrollViewIfNeeded.swift
//  InstaProfileSwiftUI
//
//  Created by Nirajan Shrestha on 01/10/2023.
//

import SwiftUI

struct ScrollViewIfNeeded<Content: View>: View {
    // MARK: - properties
    private var scrollAxes: Axis.Set
    private var showsIndicators: Bool
    
    @State private var scrollViewSize: CGSize = .zero
    @State private var contentSize: CGSize = .zero
    
    @ViewBuilder private let content: () -> Content
    
    // MARK: - init
    init(
        scrollAxes: Axis.Set = .vertical,
        showsIndicators: Bool = false,
        content: @escaping () -> Content
    ) {
        self.scrollAxes = scrollAxes
        self.showsIndicators = showsIndicators
        self.content = content
    }
    
    // MARK: - body
    var body: some View {
        ScrollView(shouldScroll ? scrollAxes : [], showsIndicators: showsIndicators) {
            content()
                .readSize { size in
                    contentSize = size
                }
        }
        .readSize { size in
            scrollViewSize = size
        }
    }

    // MARK: - shouldScroll
    private var shouldScroll: Bool {
        scrollViewSize.height <= contentSize.height
    }
}

// MARK: - PreviewProvider
struct ScrollViewIfNeeded_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewIfNeeded {
            LazyVStack {
                ForEach(0...100, id: \.self) { index in
                    Text("Text \(index)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
            }
        }
        
        ScrollViewIfNeeded {
            LazyVStack {
                ForEach(0...7, id: \.self) { index in
                    Text("Text \(index)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
            }
        }
    }
}
