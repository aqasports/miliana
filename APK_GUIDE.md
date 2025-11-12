# حاضرة مليانة - APK Building Guide

## ⚙️ Setup Requirements

Your system is missing Android SDK. Here are the options:

---

## **Option 1: Install Android Studio (Recommended)** 📱

### Step 1: Download Android Studio
1. Visit: https://developer.android.com/studio
2. Download for Windows
3. Install (default settings are fine)

### Step 2: Install Android SDK
1. Launch Android Studio
2. Go to **File** → **Settings** → **Appearance & Behavior** → **System Settings** → **Android SDK**
3. Install:
   - ✅ Android API 31+ (latest stable)
   - ✅ Android Build-Tools 35.0.0+
   - ✅ Android SDK Platform-tools
4. Click **Apply** and wait for installation

### Step 3: Configure Flutter
```powershell
flutter config --android-sdk "C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk"
```

### Step 4: Accept Licenses
```powershell
flutter doctor --android-licenses
# Press 'y' and Enter to accept all licenses
```

### Step 5: Build APK
```powershell
flutter build apk --release --split-per-abi

# Output will be at:
# build\app\outputs\flutter-apk\
```

---

## **Option 2: Use Online APK Builder (No Installation)** ⚡

### **PWA Builder** (Easiest for Web-to-APK)

1. Go to: https://www.pwabuilder.com/
2. Enter your web URL: `https://YOUR_USERNAME.github.io/miliana-app/`
3. Click **Start**
4. Download **Android APK** (automatically signed)
5. Share/install on phones

**Pros:**
- No installation needed
- 1-click APK generation
- Works with any web app
- Automatically signed for Play Store

---

## **Option 3: Appetize.io** (Web-Based Android Emulator)

1. Go to: https://appetize.io
2. Upload your `build/web/` folder as ZIP
3. Get shareable Android link
4. Anyone can test the app in browser (like native Android)

---

## **Option 4: Cordova/Capacitor** (Professional)

```powershell
npm install -g cordova
cd C:\Users\dell\Desktop\miliana\ Had\ dart
cordova create miliana-cordova
cd miliana-cordova
cordova platform add android

# Copy web build
Copy-Item -Recurse ..\build\web\* www\

# Build APK
cordova build android --release
```

**Output:** `platforms\android\app\build\outputs\apk\release\app-release.apk`

---

## 📊 Comparison

| Method | Setup Time | Effort | Cost | Result |
|--------|-----------|--------|------|--------|
| **Option 1: Android Studio** | 30-60 min | Medium | Free | Full control, native APK |
| **Option 2: PWA Builder** | 2 min | Easy | Free | Signed APK, ready for Play Store |
| **Option 3: Appetize.io** | 1 min | Very Easy | Free | Web-based Android emulator |
| **Option 4: Cordova** | 15 min | Medium | Free | Standard hybrid app |

---

## 🎯 Quick Decision

**For quick testing:** → **Option 3: Appetize.io**
**For Play Store submission:** → **Option 2: PWA Builder**
**For full Android development:** → **Option 1: Android Studio**

---

## 📲 Installing APK on Phone

Once you have an APK:

### On Phone:
1. Enable **Settings** → **Security** → **Unknown sources**
2. Copy APK to phone via USB or email
3. Open file manager, tap APK
4. Tap **Install**
5. App appears on home screen

### Via ADB (Advanced):
```powershell
# After connecting phone via USB
adb install -r "C:\path\to\app.apk"
```

---

## 🔒 Signing APK for Play Store

If using Option 2 (PWA Builder), APK is already signed.

If building with Android Studio:

```powershell
# Create keystore (one-time)
keytool -genkey -v -keystore C:\path\to\key.jks `
  -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# Build signed release APK
flutter build apk --release

# APK location: build\app\outputs\flutter-apk\app-release.apk
```

---

## 📋 Current Web Build Info

**Location:** `build/web/`
**Size:** ~12 MB
**Status:** Ready for Option 2 or 3

**Features Included:**
✅ Home page with vision & mission
✅ Mitaq (Charter) page with governance structure
✅ Mutun (Texts) with 13 matns and detail pages
✅ Programs page with course descriptions
✅ History, Scholars, Institutions pages
✅ Drawer navigation menu
✅ Logo display on all pages
✅ Arabic fonts (Cairo, Amiri, Tajawal)
✅ RTL layout support
✅ Offline capability (PWA)

---

## 🚀 Recommended Path

### **For Fastest APK (Next 5 minutes):**
1. Deploy web to GitHub Pages (5 min)
2. Use PWA Builder (2 min)
3. Get signed APK ready for store (instantly)

### Commands:
```powershell
# 1. Deploy web (if not done)
git add build/web/
git commit -m "Deploy web build"
git push

# 2. Go to https://www.pwabuilder.com/
# 3. Enter: https://USERNAME.github.io/miliana-app/
# 4. Download Android APK
# 5. Upload to Google Play or share directly
```

---

## 📞 Support

- Flutter docs: https://flutter.dev/docs/deployment/android
- PWA Builder: https://www.pwabuilder.com/
- Play Store console: https://play.google.com/console

**Your app is ready!** Choose the option that fits your needs. 🎉
