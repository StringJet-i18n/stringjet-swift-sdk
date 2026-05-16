import Foundation
import ObjectiveC

enum BundleMainLocalizationHook {
    private static var didInstall = false

    static func installIfNeeded() {
        guard !didInstall else { return }
        didInstall = true

        let selector3 = NSSelectorFromString("localizedStringForKey:value:table:")
        if
            let original = class_getInstanceMethod(Bundle.self, selector3),
            let swizzled = class_getInstanceMethod(Bundle.self, #selector(Bundle.sj_stringJet_localizedString(forKey:value:table:)))
        {
            method_exchangeImplementations(original, swizzled)
        }

        let selector4 = NSSelectorFromString("localizedStringForKey:value:table:locale:")
        if
            let original = class_getInstanceMethod(Bundle.self, selector4),
            let swizzled = class_getInstanceMethod(Bundle.self, #selector(Bundle.sj_stringJet_localizedString(forKey:value:table:locale:)))
        {
            method_exchangeImplementations(original, swizzled)
        }

        let selectorA3 = NSSelectorFromString("localizedAttributedStringForKey:value:table:")
        if
            let original = class_getInstanceMethod(Bundle.self, selectorA3),
            let swizzled = class_getInstanceMethod(Bundle.self, #selector(Bundle.sj_stringJet_localizedAttributedString(forKey:value:table:)))
        {
            method_exchangeImplementations(original, swizzled)
        }

        let selectorA4 = NSSelectorFromString("localizedAttributedStringForKey:value:table:locale:")
        if
            let original = class_getInstanceMethod(Bundle.self, selectorA4),
            let swizzled = class_getInstanceMethod(Bundle.self, #selector(Bundle.sj_stringJet_localizedAttributedString(forKey:value:table:locale:)))
        {
            method_exchangeImplementations(original, swizzled)
        }
    }
}

extension Bundle {
    @objc(sj_stringJet_localizedStringForKey:value:table:)
    func sj_stringJet_localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main && !StringJetBundle.bypassMainBundleLocalizationHook {
            return StringJetBundle.resolveForMainBundleHook(key: key, value: value, tableName: tableName)
        }
        return sj_stringJet_localizedString(forKey: key, value: value, table: tableName)
    }

    @objc(sj_stringJet_localizedStringForKey:value:table:locale:)
    func sj_stringJet_localizedString(forKey key: String, value: String?, table tableName: String?, locale: Locale?) -> String {
        if self == Bundle.main && !StringJetBundle.bypassMainBundleLocalizationHook {
            return StringJetBundle.resolveForMainBundleHook(key: key, value: value, tableName: tableName)
        }
        return sj_stringJet_localizedString(forKey: key, value: value, table: tableName, locale: locale)
    }

    @objc(sj_stringJet_localizedAttributedStringForKey:value:table:)
    func sj_stringJet_localizedAttributedString(forKey key: String, value: String?, table tableName: String?) -> NSAttributedString {
        if self == Bundle.main && !StringJetBundle.bypassMainBundleLocalizationHook {
            let resolved = StringJetBundle.resolveForMainBundleHook(key: key, value: value, tableName: tableName)
            return NSAttributedString(string: resolved)
        }
        return sj_stringJet_localizedAttributedString(forKey: key, value: value, table: tableName)
    }

    @objc(sj_stringJet_localizedAttributedStringForKey:value:table:locale:)
    func sj_stringJet_localizedAttributedString(forKey key: String, value: String?, table tableName: String?, locale: Locale?) -> NSAttributedString {
        if self == Bundle.main && !StringJetBundle.bypassMainBundleLocalizationHook {
            let resolved = StringJetBundle.resolveForMainBundleHook(key: key, value: value, tableName: tableName)
            return NSAttributedString(string: resolved)
        }
        return sj_stringJet_localizedAttributedString(forKey: key, value: value, table: tableName, locale: locale)
    }
}
