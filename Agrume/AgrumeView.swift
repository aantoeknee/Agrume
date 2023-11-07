//
//  Copyright © 2021 Schnaub. All rights reserved.
//

import SwiftUI
import UIKit

@available(iOS 14.0, *)
public struct AgrumeView: View {

  private let images: [UIImage]
  private let startIndex: Int
  @Binding private var binding: Bool
  @Namespace var namespace

  public init(image: UIImage, isPresenting: Binding<Bool>, startIndex: Int = 0) {
    self.init(images: [image], isPresenting: isPresenting, startIndex: startIndex)
  }

  public init(images: [UIImage], isPresenting: Binding<Bool>, startIndex: Int = 0) {
    self.images = images
    self._binding = isPresenting
    self.startIndex = startIndex
  }

  public var body: some View {
    WrapperAgrumeView(images: images, isPresenting: $binding, startIndex: startIndex)
      .matchedGeometryEffect(id: "AgrumeView", in: namespace, properties: .frame, isSource: binding)
      .ignoresSafeArea()
  }
}

@available(iOS 13.0, *)
struct WrapperAgrumeView: UIViewControllerRepresentable {

  private let images: [UIImage]
  private let startIndex: Int
  @Binding private var binding: Bool

    public init(images: [UIImage], isPresenting: Binding<Bool>, startIndex: Int = 0) {
    self.images = images
    self._binding = isPresenting
    self.startIndex = startIndex
  }

  public func makeUIViewController(context: UIViewControllerRepresentableContext<WrapperAgrumeView>) -> UIViewController {
    let agrume = Agrume(images: images, startIndex: self.startIndex)
    agrume.view.backgroundColor = .clear
    agrume.addSubviews()
    agrume.addOverlayView()
    agrume.willDismiss = {
        binding = false
    }
    return agrume
  }

  public func updateUIViewController(_ uiViewController: UIViewController,
                                     context: UIViewControllerRepresentableContext<WrapperAgrumeView>) {
  }
}
