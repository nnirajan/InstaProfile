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
    
    @State private var parentViewPosition: CGPoint = .zero
    
    @State private var childViewPosition: CGPoint = .zero
    
    @State private var diff: CGFloat = 0
    
//    init() {
//        UITableView.appearance().showsVerticalScrollIndicator = false
//    }
    
    var body: some View {
        GeometryReader { parentProxy in
            ScrollView(showsIndicators: false) {
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
                
                // MARK: - 1
//                Section(content: {
//                    GeometryReader { innerProxy in
//                        List {
//                            ForEach(0...100, id: \.self) { index in
//                                Text("ram \(index)")
//                                    .listRowSeparator(.hidden)
//                                    .listRowInsets(EdgeInsets())
//                                    .readScrollPosition { point in
//                                        if index == 0 {
//                                            childViewPosition = point
//                                        }
//                                    }
//                            }
//                        }
//                        .listStyle(.plain)
//                        .onAppear {
//                            UITableView.appearance().showsVerticalScrollIndicator = false
//                        }
//
////                        .readScrollPosition { point in
////                            childViewPosition = point
////                        }
//                    }
//                    .frame(width: parentProxy.size.width, height: parentProxy.size.height - 40)
////                    .offset(y:  )
//                }, header: {
//                    HStack(spacing: 0) {
//                        InstaProfileTag(selectedTab: $selectedTab, tab: .posted)
//
//                        InstaProfileTag(selectedTab: $selectedTab, tab: .tagged)
//                    }
//                })
//                .readScrollPosition { point in
//                    self.parentViewPosition = point
//                }
                
                
                
                // MARK: - 2
//                HStack(spacing: 0) {
//                    InstaProfileTag(selectedTab: $selectedTab, tab: .posted)
//
//                    InstaProfileTag(selectedTab: $selectedTab, tab: .tagged)
//                }
//
//                ZStack {
//                    List {
//                        ForEach(0...100, id: \.self) { index in
//                            Text("ram \(index)")
//                                .listRowSeparator(.hidden)
//                                .listRowInsets(EdgeInsets())
//                        }
//                    }
//                    .listStyle(.plain)
//                    .frame(width: parentProxy.size.width, height: parentProxy.size.height)
//                }
                
                
                // MARK: - 3
                Section(content: {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(0...100, id: \.self) { index in
                                Text("ram \(index)")
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    
//                                    .readScrollPosition { point in
//                                        if index == 0 {
//                                            childViewPosition = point
//                                        }
//                                    }
                            }
                        }
                        .readScrollPosition { point in
                            childViewPosition = point
                            
                            diff = childViewPosition.y - parentViewPosition.y
                        }
                    }
                    .frame(width: parentProxy.size.width, height: parentProxy.size.height - 45)
                }, header: {
                    HStack(spacing: 0) {
                        InstaProfileTag(selectedTab: $selectedTab, tab: .posted)

                        InstaProfileTag(selectedTab: $selectedTab, tab: .tagged)
                    }
                })
                .readScrollPosition { point in
                    self.parentViewPosition = point
                }
            }
//            .offset(y: childViewPosition.y - parentViewPosition.y)
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
