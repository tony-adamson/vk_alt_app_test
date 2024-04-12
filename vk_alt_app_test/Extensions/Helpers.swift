//
//  Helpers.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import Foundation
import SwiftUI

extension View {
    func customStyle() -> some View {
        modifier(TFStyleViewModifier())
    }
}

struct TFStyleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 300)
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
