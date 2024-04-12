//
//  ButtonView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 12.04.2024.
//

import SwiftUI

struct ButtonView: View {
    let isDisabled : Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text("Sign in")
                .foregroundStyle(.white)
                .font(.title2)
                .bold()
        })
        .frame(width: 300, height: 60)
        .background(LinearGradient(
            colors: isDisabled
            ? [.gray.opacity(0.6)]
            : [.orange, .blue],
            startPoint: .bottomLeading,
            endPoint: .topTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .disabled(isDisabled)
    }
}
