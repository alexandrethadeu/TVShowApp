//
//  SnapCarousel.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 31/12/21.
//

import Foundation
import SwiftUI

struct SnapCarousel<Content: View, T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    @Binding var lastIndex: Bool
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    var loadMore: () async -> Void
    
    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>, lastIndex: Binding<Bool>, items: [T], @ViewBuilder content: @escaping (T) -> Content, loadMore: @escaping () async -> Void ) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self._lastIndex = lastIndex
        self.content = content
        self.loadMore = loadMore
    }
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustMentWidht = (trailingSpace / 2) - spacing
            
            HStack(alignment: .top, spacing: spacing) {
                ForEach(list) { item in
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                }
            }
            .padding(.horizontal, spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + offset + (currentIndex != 0 ? adjustMentWidht : 0))
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        //Updating Current Index
                        let offsetX = value.translation.width
                        //Convert the translation into progress (0 - 1)
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        withAnimation {
                            currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 2), 0)
                            index = currentIndex
                            //lastIndex = true
                        }
                        
                        Task {
                            if currentIndex == list.count - 2 {
                                await loadMore()
                            }
                        }
                    })
                    .onChanged({ value in
                        //Updating Current Index
                        let offsetX = value.translation.width
                        //Convert the translation into progress (0 - 1)
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        withAnimation {
                            index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                            lastIndex = false
                        }
                    })
            )
        }
        .animation(.easeInOut, value:  offset == 0)
    }
}
