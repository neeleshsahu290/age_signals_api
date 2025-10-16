# Changelog

## 0.0.1 - Initial Release (October 2025)

🎉 **First public release of `age_signals_flutter`**

This release introduces the **Flutter plugin** providing a unified API for **age-appropriate experience management** across platforms.

### ✨ Features

- 🟢 **Android**: Integrated **Google Play Age Signals API** (`com.google.android.play:age-signals`)
  - Detects user’s verified/supervised status.
  - Provides Play Install ID & user supervision data.
- 🔵 **iOS (17+)**: Integrated **Declared Age Range API**
  - Retrieves the user’s declared age range (e.g., 13–15, 16–17).
  - Uses Apple's privacy-preserving **AgeRangeService**.
- 🧠 Unified **Flutter interface** for both platforms.
- ⚙️ Built with **Platform Channels** for full native control.
- 🧩 Example app included for testing and verification.
- 📘 Published with detailed documentation and API reference.

### 🧱 Technical Notes

- Implemented using **Kotlin** (Android) and **Swift** (iOS).
- Compatible with **Flutter 3.19+** and **Dart 3.3+**.
- Published under the **MIT License**.
- Initial package upload to **pub.dev**.

---

**Author:** [Neelesh Sahu](https://github.com/neeleshsahu290)  
**Repository:** [https://github.com/neeleshsahu290/flutter_age_signals_api](https://github.com/neeleshsahu290/flutter_age_signals_api)  
**License:** MIT