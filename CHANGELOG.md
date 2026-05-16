# Changelog

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
