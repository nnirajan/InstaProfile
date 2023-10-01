//
//  InstaProfileScreen.swift
//  InstaProfileSwiftUI
//
//  Created by Nirajan Shrestha on 30/09/2023.
//

import SwiftUI

enum InstaProfileTab {
    case posted
    case tagged
    
    var image: String {
        switch self {
        case .posted:
            return "square.grid.3x3"
        case .tagged:
            return "person"
        }
    }
    
    var isSystemImage: Bool {
        return true
    }
}

struct InstaProfileScreen: View {
    // MARK: - properties
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @State private var safeAreas: EdgeInsets = .init()
    
    @State private var selectedTab: InstaProfileTab = .posted
    
    @State private var parentSize: CGSize = .zero
    @State private var sectionHeaderViewSize: CGSize = .zero
    
    @State private var parentViewPosition: CGPoint = .zero
    @State private var childViewPosition: CGPoint = .zero
    @State private var diff: CGFloat = 0
    @State private var makeOffset: CGFloat = 0
    
    var body: some View {
        // MARK: - 1st try
        /// parentView
        ScrollView(.vertical, showsIndicators: false) {
            /// headerViews
            VStack {
                InstaHeaderView()

                InstaStoryView()
            }
            .padding(.vertical)

            Text("parent: \(parentViewPosition.y)")
            Text("child: \(childViewPosition.y)")
            Text("diff: \(diff)")

            
            // MARK: - 1
            /// childView
//                /// tabViews
//                Section(content: {
//                    TabView(selection: $selectedTab, content: {
//                        PostedScreen()
//                            .background(.yellow)
//                            .tag(InstaProfileTab.posted)
//
//                        TaggedScreen()
//                            .background(.yellow)
//                            .tag(InstaProfileTab.tagged)
//                    })
//                    .frame(width: parentProxy.size.width,
//                           height: parentProxy.size.height - sectionHeaderViewSize.height)
//                    .background(.yellow)
//                    .tabViewStyle(.page(indexDisplayMode: .never))
//                }, header: {
//                    /// sectionHeader
//                    HStack(spacing: 0) {
//                        InstaProfileTag(selectedTab: $selectedTab, tab: .posted)
//
//                        InstaProfileTag(selectedTab: $selectedTab, tab: .tagged)
//                    }
//                    .readSize { size in
//                        sectionHeaderViewSize = size
//                    }
//                })

            // MARK: - 2
            Section(content: {
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(0...100, id: \.self) { index in
                            Text("ram \(index)")
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .readScrollPosition { point in
                        childViewPosition = point

                        //                            diff = childViewPosition.y - parentViewPosition.y
                    }
                }
                .frame(width: parentSize.width,
                       height: parentSize.height - sectionHeaderViewSize.height)
                .background(.yellow)
            }, header: {
                /// sectionHeader
                HStack(spacing: 0) {
                    InstaProfileTag(selectedTab: $selectedTab, tab: .posted)

                    InstaProfileTag(selectedTab: $selectedTab, tab: .tagged)
                }
                .readSize { size in
                    sectionHeaderViewSize = size
                }
            })
        }
        .readSize { size in
            parentSize = size
        }
        .overlay(alignment: .top) {
            Color.green
                .frame(height: safeAreaInsets.top)
                .ignoresSafeArea(edges: .top)
        }
    }
}

// MARK: - PreviewProvider
struct InstaProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        InstaProfileScreen()
    }
}
