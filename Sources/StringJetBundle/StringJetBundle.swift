import Foundation
import sdkKit

public enum StringJetBundle {
    public enum LocalizationFormat {
        /// Legacy `Localizable.strings` / `NSLocalizedString` bundles (not Xcode String Catalog / `.xcstrings`).
        case stringResources
        /// String Catalog file `Localizable.xcstrings` with `String(localized:)` (default).
        case xcstrings
    }

    static var bypassMainBundleLocalizationHook = false

    public static func configure(
        sdkToken: String,
        projectId: String,
        localizationFormat: LocalizationFormat = .xcstrings,
        otaChannel: OtaChannel = .production
    ) {
        let legacyLocalization = localizationFormat == .stringResources
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        let base = urls.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
        let cachesPath = base.appendingPathComponent("StringJet", isDirectory: true).path
        StringJet.shared.initialize(
            cachesPath: cachesPath,
            sdkToken: sdkToken,
            projectId: projectId,
            legacyLocalization: legacyLocalization,
            otaChannel: otaChannel,
            fetchOnInit: false
        )
        BundleMainLocalizationHook.installIfNeeded()
    }

    public static func syncTranslations() {
        StringJet.shared.syncTranslations()
    }

    static func resolveForMainBundleHook(key: String, value: String?, tableName: String?) -> String {
        let normalizedTable: String?
        if let tableName {
            let trimmed = tableName.trimmingCharacters(in: .whitespacesAndNewlines)
            normalizedTable = trimmed.isEmpty ? nil : trimmed
        } else {
            normalizedTable = nil
        }

        let resolved = StringJetIosBridge.shared.resolveLocalizedString(
            key: key,
            value: value,
            tableName: normalizedTable
        )
        if !resolved.isEmpty {
            return resolved
        }

        bypassMainBundleLocalizationHook = true
        defer { bypassMainBundleLocalizationHook = false }
        return Bundle.main.localizedString(forKey: key, value: value, table: normalizedTable)
    }

    /// Resolves a localization key from the StringJet OTA cache, falling back to the app bundle when no OTA value exists.
    public static func localized(_ key: String, table: String? = nil) -> String {
        resolveForMainBundleHook(key: key, value: nil, tableName: table)
    }
}

extension String {
    /// Localized string that prefers StringJet OTA values over the bundled catalog or strings file.
    public init(localized key: String, comment: StaticString? = nil) {
        _ = comment
        self = StringJetBundle.localized(key)
    }
}
