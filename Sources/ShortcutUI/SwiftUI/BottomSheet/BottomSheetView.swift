//
//  BottomSheetView.swift
//  ShortcutUI
//
//  Created by Darya Gurinovich on 2022-01-07.
//  Copyright © 2022 Shortcut Scandinavia Apps AB. All rights reserved.
//

import SwiftUI

#if !os(macOS) && !os(tvOS)
struct SheetView<Content: View>: View {
    let content: Content
    let options: [BottomSheet.Options]

    @GestureState private var translation: CGFloat = 0
    @Binding private var isOpened: Bool

    init(content: Content,
         options: [BottomSheet.Options] = [],
         isOpened: Binding<Bool>) {
        self.content = content
        self.options = options

        self._isOpened = isOpened
    }

    var body: some View {
        Group {
            options.contentBackground
                .edgesIgnoringSafeArea(.all)
                .onTapGesture(perform: closeOnTap)
                .transition(.opacity)

            GeometryReader { proxy in
                if !options.disableSwipeToDismiss {
                    sheetView
                        .gesture(
                            DragGesture().updating(self.$translation) { value, state, _ in
                                state = value.translation.height
                            }.onEnded { value in
                                let snapDistance = proxy.size.height * .sheetSnapRatio
                                guard abs(value.translation.height) > snapDistance else {
                                    return
                                }

                                changeSheetOpenedStatus(value.translation.height < 0)
                            }
                        )
                }
                else {
                    sheetView
                }
            }
            .transition(.move(edge: .bottom))
        }
        .animation(options.animation)
    }

    private var indicator: some View {
        Capsule()
            .fill(options.dragIndicatorColor)
            .frame(width: .indicatorSize.width, height: .indicatorSize.height)
    }
    
    private var sheetView: some View {
        VStack {
            if !options.noDragIndicator {
                indicator
            }

            content
                .frame(maxHeight: .infinity)
        }
        .padding(options.elementsPadding)
        .frame(maxWidth: .infinity, maxHeight: options.maxHeight)
        .background(
            options.background
                .cornerRadius(options.cornerRadius, corners: [.topLeft, .topRight])
                .edgesIgnoringSafeArea(.bottom)
        )
        .padding(.top, options.topPadding)
        .offset(y: max(self.translation, 0))
        .frame(maxHeight: .infinity, alignment: .bottom)
    }

    private func closeOnTap() {
        guard options.tapToDismiss else { return }

        changeSheetOpenedStatus(false)
    }

    private func changeSheetOpenedStatus(_ opened: Bool) {
        withAnimation(options.animation) {
            self.isOpened = opened
        }
    }
}

private extension CGFloat {
    static var indicatorSize = CGSize(width: 70, height: 4)
    static var sheetSnapRatio = 0.2
}

// MARK: - Preview

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
    
    private struct TestView: View {
        var body: some View {
            SheetView(content: ModalContentView(),
                      options: [.background(background),
                                .maxHeight(500),
                                .disableSwipeToDismiss],
                      isOpened: .constant(true))
        }
        
        private var background: AnyView {
            Color.blue.opacity(0.2).eraseToAnyView()
        }
    }
    
    private struct ModalContentView: View {
        var body: some View {
            Text("Hello World!")
        }
    }
}

#endif
