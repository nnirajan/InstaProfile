//
//  PinHeader.swift
//  InstaProfileSwiftUI
//
//  Created by Nirajan Shrestha on 01/10/2023.
//

import SwiftUI

struct PinHeader: View {
    @State private var width: CGFloat? = nil
    
    
    var body: some View {
        ScrollViewReader { proxy in
            GeometryReader { geometry in // <-- to get the viewport size
                ScrollView([.vertical, .horizontal]) {
                    ZStack(alignment: .topLeading) { // to place the scroll anchor
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("hello")
                            }
                            .stickyHorizontal(geometry.size.width, scrollWidth: width)
                            
                            ForEach(0..<2) { i in
                                LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
                                    Section(content: {
                                        Text("hello hello hello hello")
                                    }, header: {
                                        Text("header1")
                                        // calculating the width of header (i.e. the width of table)
                                            .background(GeometryReader { geometry in
                                                Color.clear
                                                    .onAppear {
                                                        width = geometry.size.width
                                                    }
                                                    .onChange(of: geometry.size.width) { newValue in
                                                        width = newValue
                                                    }
                                            })
                                    })
                                }
                            }
                            
//                            // addtional views (footer)
//                            ...
                            
                            // act as a Spacer(). Stretching the VStack.
                            Color.clear
                                .frame(height: geometry.size.height - 40)
                        }
                        .frame(width: width)
                        
                        // scroll destination
                        Color.clear
                            .frame(width: 1, height: 1)
                            .id("topLeading")
                    }
                    .onAppear {
                        // make sure the scroll view appears from top leading.
                        proxy.scrollTo("topLeading", anchor: .topLeading)
                    }
                }
            }
        }
    }
}

struct PinHeader_Previews: PreviewProvider {
    static var previews: some View {
        PinHeader()
    }
}


extension View {
    @ViewBuilder
    func stickyHorizontal(_ viewPortWidth: CGFloat, scrollWidth: CGFloat?) -> some View {
        LazyHStack( spacing: 0, pinnedViews: .sectionHeaders) {
            Section {
                Color.clear
                    .frame(width: scrollWidth == nil ? nil : scrollWidth! - viewPortWidth)
            } header: {
                self
                    .frame(width: viewPortWidth)
            }
        }
    }
}
