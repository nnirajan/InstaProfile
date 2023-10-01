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
    @State private var selectedTab: InstaProfileTab = .posted
    
    @State private var headerViewSize: CGSize = .zero
    @State private var sectionHeaderViewSize: CGSize = .zero
    
    @State private var parentViewPosition: CGPoint = .zero
    
    @State private var childViewPosition: CGPoint = .zero
    
    @State private var diff: CGFloat = 0
    
    @State private var makeOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { parentProxy in
            ScrollView(.vertical, showsIndicators: false) {
                /// headerViews
                Group {
                    InstaHeaderView()

                    InstaStoryView()
                }
                .readSize { size in
                    headerViewSize = size
                }
                
                Text("parent: \(parentViewPosition.y)")
                Text("child: \(childViewPosition.y)")
                Text("diff: \(diff)")
                
                /// tabViews
                Section(content: {
                    TabView(selection: $selectedTab, content: {
                        PostedScreen()
                            .background(.yellow)
                            .tag(InstaProfileTab.posted)

                        TaggedScreen()
                            .background(.yellow)
                            .tag(InstaProfileTab.tagged)
                    })
                    .frame(width: parentProxy.size.width,
                           height: parentProxy.size.height - sectionHeaderViewSize.height)
                    .background(.yellow)
                    .tabViewStyle(.page(indexDisplayMode: .never))
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


                
//                Section(content: {
//                    ScrollView(.vertical, showsIndicators: false) {
//                        LazyVStack(alignment: .leading, spacing: 16, pinnedViews: [.sectionHeaders]) {
//                            ForEach(0...100, id: \.self) { index in
//                                Text("ram \(index)")
//                                    .frame(height: 50)
//                                    .frame(maxWidth: .infinity)
//                            }
//                        }
//                        .readScrollPosition { point in
//                            childViewPosition = point
//
////                            diff = childViewPosition.y - parentViewPosition.y
//                        }
//                    }
////                    .frame(width: parentProxy.size.width, height: parentProxy.size.height - 45)
////                    .background(.red)
//
//                }, header: {
//                    HStack(spacing: 0) {
//                        InstaProfileTag(selectedTab: $selectedTab, tab: .posted)
//
//                        InstaProfileTag(selectedTab: $selectedTab, tab: .tagged)
//                    }
//                    .frame(height: 100)
//                })
//                .readScrollPosition { point in
//                    self.parentViewPosition = point
//                }
            }
            .overlay(alignment: .top) {
                Color.white
                    .frame(height: parentProxy.safeAreaInsets.top)
                    .ignoresSafeArea(edges: .top)
            }
        }
    }
}

struct InstaProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        InstaProfileScreen()
    }
}


struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

extension View {
    func readScrollPosition(perform action: @escaping (CGPoint) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .global).origin)
            }
        )
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            action(value)
        }
        
    }
}
