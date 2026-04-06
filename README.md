# 📷 SwiftUI Camera Example

A SwiftUI app that accesses the device camera using `AVCaptureSession`, displays a live camera preview, and demonstrates how to bridge UIKit's camera layer into a SwiftUI view.

---

## 🤔 What this is

This project shows the standard pattern for embedding a camera feed into SwiftUI via `UIViewRepresentable`. It wraps an `AVCaptureSession` with a `AVCaptureVideoPreviewLayer` inside a `UIView`, then surfaces that as a native SwiftUI view — covering permissions, session setup, and teardown.

## ✅ Why you'd use it

- **UIViewRepresentable bridge** — clean pattern for embedding `AVCaptureVideoPreviewLayer` in SwiftUI
- **Session lifecycle** — start/stop capture session with proper setup and teardown
- **Permission handling** — requests camera access and handles authorization states
- **Single-file simplicity** — everything lives in `ContentView.swift`, easy to extract into your own project

## 📺 Watch on YouTube

[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/hB8MTEJj3CA)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@NoahDoesCoding97).

---

## 🚀 Getting Started

### 1. Clone the Repo
```bash
git clone https://github.com/NDCSwift/SwiftUICameraExample.git
cd SwiftUICameraExample
```

### 2. Open in Xcode
- Double-click `CameraExample.xcodeproj`

### 3. Set Your Development Team
In Xcode: **TARGET → Signing & Capabilities → Team**

### 4. Update the Bundle Identifier
Change `com.example.MyApp` to a unique identifier (e.g., `com.yourname.CameraExample`).

---

## 🛠️ Notes

- `NSCameraUsageDescription` must be set in Info.plist — add a description string for the camera permission prompt.
- The camera does **not** work in the simulator; run on a physical device.
- If you see a code signing error, check that Team and Bundle ID are set.

## 📦 Requirements

- iOS 16+
- Xcode 15+
- Swift 5.9+
- Physical device required for camera preview

---

📺 [Watch the guide on YouTube](https://youtu.be/hB8MTEJj3CA)
