import Foundation
import sdkKit

public enum StringJetBundle {
    public enum LocalizationFormat {
        case stringcatalog
        case xcstrings
    }

    static var bypassMainBundleLocalizationHook = false

    public static func configure(
        sdkToken: String,
        projectId: String,
        localizationFormat: LocalizationFormat = .xcstrings,
        otaChannel: OtaChannel = .production
    ) {
        let legacyLocalization = localizationFormat == .stringcatalog
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
}
