import Foundation
import ObjectiveC

final class StringJetMainBundle: Bundle, @unchecked Sendable {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if !StringJetBundle.bypassMainBundleLocalizationHook {
            return StringJetBundle.resolveForMainBundleHook(key: key, value: value, tableName: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}

enum StringJetMainBundleSwap {
    private static var didInstall = false

    static func installIfNeeded() {
        guard !didInstall else { return }
        didInstall = true
        guard StringJetBundle.installBundleMainSwap else { return }
        object_setClass(Bundle.main, StringJetMainBundle.self)
    }
}
