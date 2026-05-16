# Changelog

## 0.3.0

- OTA-published strings now flow transparently through every native Apple/SwiftUI localization API — `Text(...)`, `Label(...)`, `Button(...)`, `Toggle(...)`, `.navigationTitle(...)`, `.searchable(prompt:)`, `String(localized:)`, `NSLocalizedString`, and `String.localizedStringWithFormat`. No code changes, no helper API, no migration required.
- Existing `LocalizedStringKey("…")` call sites resolve to OTA values automatically — `Label(LocalizedStringKey("settings_enable_pip"), systemImage: "pip")` shows the OTA-published copy as soon as `syncTranslations()` finishes.
- The `StringJet.bundle` cache on disk now always contains both `Localizable.xcstrings` (debug tooling) and runtime-readable `.lproj/Localizable.strings` + `.lproj/Localizable.stringsdict` (plurals) regardless of `localizationFormat`.
- Behavior change to flag: by default StringJet now installs a `Bundle.main` subclass that intercepts every localization selector. Opt out with `StringJetBundle.installBundleMainSwap = false` **before** calling `configure(...)` if your app needs the original `Bundle.main` instance preserved.

## 0.2.1

- Fixed OTA-published strings not appearing when using `String(localized:)` with Xcode String Catalog (`.xcstrings`).
- Fixed OTA format strings using Apple-compatible placeholders (resolves `String(format:)` specifier mismatch warnings).
- Fixed literal `\n` in OTA values rendering as two characters instead of a line break.
- Import `StringJetBundle` in Swift files that use `String(localized:)` so OTA lookups apply.

## 0.2.0

- **Breaking:** `StringJetBundle.LocalizationFormat` renamed **`stringcatalog` → `stringResources`** for the legacy `Localizable.strings` / `NSLocalizedString` track. Use **`localizationFormat: .stringResources`** instead of `.stringcatalog`. Default remains **`.xcstrings`** (String Catalog file).
- Documentation: [developer.stringjet.com](https://developer.stringjet.com) iOS sections reframed as **string resources**; README links updated.

## 0.1.0

- Initial Swift package wrapper around the Kotlin `sdkKit` XCFramework.
