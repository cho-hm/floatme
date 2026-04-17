import SwiftUI
import ServiceManagement

struct SettingsView: View {
    var store: SettingsStore

    var body: some View {
        Form {
            Section("일반") {
                Toggle("로그인 시 자동 시작", isOn: Binding(
                    get: { store.settings.launchAtLogin },
                    set: { newValue in
                        store.settings.launchAtLogin = newValue
                        if newValue {
                            try? SMAppService.mainApp.register()
                        } else {
                            try? SMAppService.mainApp.unregister()
                        }
                    }
                ))
                Toggle("Dock 아이콘 숨기기", isOn: Binding(
                    get: { store.settings.hideDockIcon },
                    set: { newValue in
                        store.settings.hideDockIcon = newValue
                        NSApp.setActivationPolicy(newValue ? .accessory : .regular)
                    }
                ))
            }

            Section("외관") {
                Picker("배경 스타일", selection: Binding(
                    get: { store.settings.backgroundStyle },
                    set: { store.settings.backgroundStyle = $0 }
                )) {
                    Text("블러 (시스템)").tag(BackgroundStyle.blur)
                    Text("다크").tag(BackgroundStyle.dark)
                    Text("투명").tag(BackgroundStyle.transparent)
                }

                HStack {
                    Text("아이콘 크기")
                    Slider(value: Binding(
                        get: { Double(store.settings.iconSize) },
                        set: { store.settings.iconSize = Int($0) }
                    ), in: 20...48, step: 2)
                    Text("\(store.settings.iconSize)px")
                        .monospacedDigit()
                        .frame(width: 40)
                }

                HStack {
                    Text("배경 투명도")
                    Slider(value: Binding(
                        get: { store.settings.backgroundOpacity },
                        set: { store.settings.backgroundOpacity = $0 }
                    ), in: 0.5...1.0)
                    Text("\(Int(store.settings.backgroundOpacity * 100))%")
                        .monospacedDigit()
                        .frame(width: 40)
                }
            }

            Section("동작") {
                Toggle("전체화면에서 숨기기", isOn: Binding(
                    get: { store.settings.hideInFullscreen },
                    set: { store.settings.hideInFullscreen = $0 }
                ))
                Toggle("화면 가장자리 스냅", isOn: Binding(
                    get: { store.settings.edgeSnap },
                    set: { store.settings.edgeSnap = $0 }
                ))

                Picker("방향", selection: Binding(
                    get: { store.settings.orientation },
                    set: { store.settings.orientation = $0 }
                )) {
                    Text("가로").tag(BarOrientation.horizontal)
                    Text("세로").tag(BarOrientation.vertical)
                }
            }
        }
        .formStyle(.grouped)
        .frame(width: 380, height: 400)
    }
}
