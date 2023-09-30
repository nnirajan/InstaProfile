//
//  InstaProfileTag.swift
//  InstaProfileSwiftUI
//
//  Created by Nirajan Shrestha on 30/09/2023.
//

import SwiftUI

struct InstaProfileTag: View {
    @Binding private var selectedTab: InstaProfileTab
    
    private var tab: InstaProfileTab
    
    // MARK: - init
    init(
        selectedTab: Binding<InstaProfileTab>,
        tab: InstaProfileTab
    ) {
        self._selectedTab = selectedTab
        self.tab = tab
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Button(action: {
                withAnimation(.easeInOut) {
                    selectedTab = tab
                }
            }, label: {
                (
                    tab.isSystemImage ? Image(systemName: tab.image) : Image(tab.image)
                )
                .renderingMode(.template)
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(tab == selectedTab ? .primary : .gray)
            })
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(tab == selectedTab ? .primary : .clear)
        }
    }
}

// MARK: - PreviewProvider
struct InstaProfileTag_Previews: PreviewProvider {
    static var previews: some View {
        InstaProfileTag(selectedTab: .constant(.posted), tab: .posted)
    }
}
