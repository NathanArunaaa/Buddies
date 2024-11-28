import SwiftUI

struct MainView: View {
    @State private var notificationsEnabled = false
    @State private var locationDisplayed = false
    @State private var arFeaturesEnabled = false
    @Environment(\.presentationMode) var presentationMode

    private enum UserDefaultsKeys {
        static let notificationsEnabled = "notificationsEnabled"
        static let locationDisplayed = "locationDisplayed"
        static let arFeaturesEnabled = "arFeaturesEnabled"
    }

    private func saveSettings() {
        UserDefaults.standard.set(notificationsEnabled, forKey: UserDefaultsKeys.notificationsEnabled)
        UserDefaults.standard.set(locationDisplayed, forKey: UserDefaultsKeys.locationDisplayed)
        UserDefaults.standard.set(arFeaturesEnabled, forKey: UserDefaultsKeys.arFeaturesEnabled)
    }

    private func loadSettings() {
        notificationsEnabled = UserDefaults.standard.bool(forKey: UserDefaultsKeys.notificationsEnabled)
        locationDisplayed = UserDefaults.standard.bool(forKey: UserDefaultsKeys.locationDisplayed)
        arFeaturesEnabled = UserDefaults.standard.bool(forKey: UserDefaultsKeys.arFeaturesEnabled)
    }

    var body: some View {
            VStack {
                HStack {
                    Button(action: {
                        HapticFeedbackManager.shared.triggerImpact(style: .medium)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "person.2.fill")
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                    Text("Buddies")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.black)
                .padding(.top, 10)

                Form {
                    Section {
                            HStack {
                                
                                    Circle()
                                        .fill(Color.gray)
                                        .frame(width: 50, height: 50)
                                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                

                                VStack(alignment: .leading) {
                                    Text("username")
                                        .font(.headline)
                                    Text("useremail@mail.com")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(.leading)
                                Spacer()
                                                    }
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color(hex: "#151517"))
                    }

                    CustomSection(header: "GENERAL") {
                        Toggle(isOn: $notificationsEnabled) {
                            HStack {
                                Image(systemName: "bell")
                                Text("Notifications")
                                    .padding(.vertical, 5)
                            }
                        }
                        .onChange(of: notificationsEnabled, perform: { _ in
                            saveSettings()
                        })

                        Toggle(isOn: $locationDisplayed) {
                            HStack {
                                Image(systemName: "lock")
                                Text("Convoy Privacy")
                                    .padding(.vertical, 5)
                            }
                        }
                        .onChange(of: locationDisplayed, perform: { _ in
                            saveSettings()
                        })

                        Toggle(isOn: $arFeaturesEnabled) {
                            HStack {
                                Image(systemName: "antenna.radiowaves.left.and.right")
                                Text("Data Saver")
                                    .padding(.vertical, 5)
                            }
                        }
                        .onChange(of: arFeaturesEnabled, perform: { _ in
                            saveSettings()
                        })

                        
                    }

                    CustomSection(header: "INFO") {
                        Button(action: {
                            if let url = URL(string: "https://cnvyapp.com/about") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("About Us")
                                    .padding(.vertical, 5)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(PlainButtonStyle())

                        Button(action: {
                            if let url = URL(string: "https://cnvyapp.com/help") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "questionmark.circle")
                                Text("Help")
                                    .padding(.vertical, 5)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    CustomSection(header: "MORE") {
                        Button(action: {
                            if let url = URL(string: "https://cnvyapp.com/share") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                                    .padding(.vertical, 5)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(PlainButtonStyle())

                        Button(action: {
                            if let url = URL(string: "https://cnvyapp.com/rate") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "star")
                                Text("Rate")
                                    .padding(.vertical, 5)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    Button(action: {
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                    }
                    .listRowBackground(Color(hex: "#151517"))
                }
                .listStyle(InsetGroupedListStyle())
                .onAppear {
                    loadSettings()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .preferredColorScheme(.dark)
        }
    }


struct CustomSection<Content: View>: View {
    let header: String
    let content: () -> Content

    init(header: String, @ViewBuilder content: @escaping () -> Content) {
        self.header = header
        self.content = content
    }

    var body: some View {
        Section(header: HStack {
            Text(header)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
        }) {
            VStack {
                content()
            }
            .listRowBackground(Color(hex: "#151517"))
        }
    }
}

struct AccountView: View {
    var body: some View {
        Text("Blocked Users")
    }
}

struct AboutUsView: View {
    var body: some View {
        Text("About Us")
    }
}

struct HelpView: View {
    var body: some View {
        Text("Help")
    }
}

struct ShareMomentsView: View {
    var body: some View {
        Text("Share Moments")
    }
}

struct RateMomentsView: View {
    var body: some View {
        Text("Rate Moments")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
