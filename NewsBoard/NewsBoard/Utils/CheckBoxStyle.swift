//
//  CheckBoxStyle.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/23.
//

import Foundation
import SwiftUI

struct CheckboxStyle: ToggleStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            if configuration.isOn {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.accentColor)
                    .font(.system(size: 18, weight: .regular, design: .default))
            }
            else {
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
                    .font(.system(size: 18, weight: .regular, design: .default))
            }
            configuration.label
        }
        .animation(Animation.linear(duration: 0.1))
        .transition(.opacity)
        .onTapGesture {
            withAnimation {
                configuration.isOn.toggle()
            }
        }
 
    }
}
