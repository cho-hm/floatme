import SwiftUI

struct AppSelectorView: View {
    var store: SettingsStore
    var monitor: RunningAppMonitor
    @State private var searchText = ""

    private var filteredApps: [RunningAppInfo] {
        let apps = monitor.runningApps
        if searchText.isEmpty { return apps }
        return apps.filter { $0.localizedName.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        VStack(spacing: 0) {
            TextField("검색...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding(12)

            ScrollView {
                LazyVStack(spacing: 2) {
                    ForEach(filteredApps) { app in
                        let isPinned = store.settings.pinnedApps.contains { $0.bundleIdentifier == app.bundleIdentifier }

                        Button {
                            withAnimation {
                                store.toggleApp(app.bundleIdentifier, name: app.localizedName)
                            }
                        } label: {
                            HStack(spacing: 10) {
                                Image(nsImage: app.icon)
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))

                                Text(app.localizedName)
                                    .lineLimit(1)

                                Spacer()

                                if isPinned {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(isPinned ? Color.blue.opacity(0.1) : Color.clear)
                            .cornerRadius(8)
                        }
                        .buttonStyle(.plain)
                        .disabled(!isPinned && !store.canAddMore)
                        .opacity(!isPinned && !store.canAddMore ? 0.4 : 1)
                    }
                }
                .padding(.horizontal, 8)
            }
            .frame(maxHeight: 240)

            if !store.canAddMore {
                Text("최대 \(SettingsStore.maxPinnedApps)개까지 등록 가능합니다")
                    .font(.caption2)
                    .foregroundStyle(.orange)
                    .padding(.horizontal, 12)
                    .padding(.top, 4)
            }

            HStack {
                Text("실행 중 \(monitor.runningApps.count)개")
                Spacer()
                Text("플로팅 \(store.settings.pinnedApps.count)/\(SettingsStore.maxPinnedApps)")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(12)
        }
        .frame(width: 260)
    }
}
