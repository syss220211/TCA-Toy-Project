//
//  Font.swift
//  TCA-Toy-Project
//
//  Created by 박서연 on 1/2/25.
//  Copyright © 2025 yapp25-toy-project. All rights reserved.
//

import SwiftUI
import UIKit

extension Font {
    static func bold(_ size: CGFloat) -> Font {
        return TCAToyProjectFontFamily.Pretendard.bold.swiftUIFont(size: size)
    }
    
    static func medium(_ size: CGFloat) -> Font {
        return TCAToyProjectFontFamily.Pretendard.medium.swiftUIFont(size: size)
    }
    
    static func regular(_ size: CGFloat) -> Font {
        return TCAToyProjectFontFamily.Pretendard.regular.swiftUIFont(size: size)
    }
}

enum TFont {
    case title1
    case title2
    case head1
    case body1
    case body2
    case caption1
    
    var type: String {
        switch self {
        case .title1:
            return TCAToyProjectFontFamily.Pretendard.bold.name
        case .title2:
            return TCAToyProjectFontFamily.Pretendard.bold.name
        case .head1:
            return TCAToyProjectFontFamily.Pretendard.bold.name
        case .body1:
            return TCAToyProjectFontFamily.Pretendard.medium.name
        case .body2:
            return TCAToyProjectFontFamily.Pretendard.regular.name
        case .caption1:
            return TCAToyProjectFontFamily.Pretendard.regular.name
        }
    }
    
    var size: CGFloat {
        switch self {
        case .title1:
            return 30
        case .title2:
            return 24
        case .head1:
            return 16
        case .body1:
            return 14
        case .body2:
            return 12
        case .caption1:
            return 10
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .title1:
            return 0
        case .title2:
            return 0
        case .head1:
            return 0
        case .body1:
            return TFont.body1.size * 0.15
        case .body2:
            return TFont.body2.size * 0.15
        case .caption1:
            return TFont.caption1.size * 0.15
        }
    }
    
    var applyFont: Font {
        switch self {
        case .title1:
            return .bold(self.size)
        case .title2:
            return .bold(self.size)
        case .head1:
            return .bold(self.size)
        case .body1:
            return .medium(self.size)
        case .body2:
            return .regular(self.size)
        case .caption1:
            return .regular(self.size)
        }
    }
    
    var toFont: Font {
        return Font.custom(self.type, size: self.size)
    }
    
    var toUIFont: UIFont {
        return UIFont(name: self.type, size: self.size) ?? UIFont.systemFont(ofSize: self.size)
    }
}

struct FontModifier: ViewModifier {
    let font: TFont
    
    init(font: TFont) {
        self.font = font
    }
    
    func body(content: Content) -> some View {
        content
            .font(font.applyFont)
            .padding(.vertical, font.lineHeight)
    }
}

extension View {
    func applyFont(font: TFont) -> some View {
        modifier(FontModifier(font: font))
    }
}

struct TText: View {
    let title: String
    let fontType: TFont
    let color: Color?
    
    init(
        _ title: String,
        fontType: TFont,
        color: Color? = Color.textMain
    ) {
        self.title = title
        self.fontType = fontType
        self.color = color
    }
    
    var body: some View {
        Text(title)
            .applyFont(font: fontType)
            .foregroundStyle(color ?? Color.textMain)
    }
}
