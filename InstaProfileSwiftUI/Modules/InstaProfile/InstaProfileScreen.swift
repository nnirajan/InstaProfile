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
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]
    
    var body: some View {
        /// parentView
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders], content: {
                /// headerViews
                VStack {
                    InstaHeaderView()
                    
                    InstaStoryView()
                }
                .padding(.vertical)
                
//                Text("parentsize: \(parentSize.height)")
//                Text("parentViewPosition: \(parentViewPosition.y)")
//                Text("child: \(childViewPosition.y)")
//                Text("diff: \(diff)")

                /// tabview
                Section(content: {
//                    LazyVGrid(columns: columns, spacing: 10) {
//                        ForEach(0...30, id: \.self) { index in
//                            Text("ram \(index)")
//                                .frame(height: 100)
//                                .frame(maxWidth: .infinity)
//                                .background(.red)
//                        }
//                    }
                    
//                    TabView(selection: $selectedTab) {
//                        PostedScreen()
//                            .background(.yellow)
//                            .tag(InstaProfileTab.posted)
//                            .frame(height: 100)
//    
//                        TaggedScreen()
//                            .background(.red)
//                            .tag(InstaProfileTab.tagged)
//                    }
//                    .tabViewStyle(.page(indexDisplayMode: .never))
//                    .frame(height: 500)
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
