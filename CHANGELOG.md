# Changelog

## 0.2.0

- **Breaking:** `StringJetBundle.LocalizationFormat` renamed **`stringcatalog` → `stringResources`** for the legacy `Localizable.strings` / `NSLocalizedString` track. Use **`localizationFormat: .stringResources`** instead of `.stringcatalog`. Default remains **`.xcstrings`** (String Catalog file).
- Documentation: [developer.stringjet.com](https://developer.stringjet.com) iOS sections reframed as **string resources**; README links updated.

## 0.1.0

- Initial Swift package wrapper around the Kotlin `sdkKit` XCFramework.
