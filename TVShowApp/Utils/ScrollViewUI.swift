//
//  ScrollViewUI.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 31/12/21.
//

import Foundation
import SwiftUI
import UIKit

struct ScrollViewUI<Content: View>: UIViewControllerRepresentable {

  var content: () -> Content
  var hideScrollIndicators: Bool = false

  init(hideScrollIndicators: Bool, @ViewBuilder content: @escaping () -> Content) {
      self.content = content
      self.hideScrollIndicators = hideScrollIndicators
  }

  func makeUIViewController(context: Context) -> ScrollViewController<Content> {
      let vc = ScrollViewController(rootView: self.content())
      vc.hideScrollIndicators = hideScrollIndicators
      return vc
  }

  func updateUIViewController(_ viewController: ScrollViewController<Content>, context: Context) {
      viewController.hostingController.rootView = self.content()
  }
}
