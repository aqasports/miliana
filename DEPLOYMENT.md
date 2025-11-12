# حاضرة مليانة - Deployment Guide

## 🚀 GitHub Pages Hosting (Free & Easy)

### Step 1: Create a GitHub Repository

1. Go to [GitHub.com](https://github.com) and sign in
2. Click **New Repository** button
3. Fill in:
   - **Repository name:** `miliana-app` (or any name)
   - **Description:** حاضرة مليانة - Miliana App
   - **Visibility:** Public (required for free GitHub Pages)
   - Click **Create Repository**

### Step 2: Push Your Web Build to GitHub

Open PowerShell in your project folder and run:

```powershell
# Initialize git if not already done
git init

# Add the remote repository (replace USERNAME and REPO with your values)
git remote add origin https://github.com/USERNAME/miliana-app.git

# Create a deploy folder with the web build
mkdir deploy
Copy-Item -Recurse build\web\* deploy\

# Add and commit
git add deploy/
git commit -m "Add web build for GitHub Pages"

# Push to GitHub
git branch -M main
git push -u origin main
```

### Step 3: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** (top right)
3. Scroll left sidebar to **Pages**
4. Under "Build and deployment":
   - **Source:** Select "Deploy from a branch"
   - **Branch:** Select `main` and `/root` folder (or `/deploy` if you created deploy folder)
   - Click **Save**
5. Wait 1-2 minutes for deployment

### Step 4: Access Your App

Your app will be live at:
```
https://USERNAME.github.io/miliana-app/
```

---

## 📱 Install as PWA (Web App)

### On Android:
1. Open `https://USERNAME.github.io/miliana-app/` in Chrome
2. Tap menu (⋮) → **Install app** (or **Add to Home Screen**)
3. App appears as native app on home screen

### On iPhone:
1. Open in Safari
2. Tap Share → **Add to Home Screen**
3. Name it "حاضرة مليانة"

### On Desktop (Windows/Mac):
1. Visit the URL in Chrome
2. Click app install icon (top right address bar)
3. Or: Menu (⋮) → **Create shortcut**

---

## 🔧 Alternative Hosting Options

### Netlify (Easiest)
1. Go to [netlify.com](https://netlify.com)
2. Sign in with GitHub
3. Click **New site from Git**
4. Select your repository
5. Set build command: `flutter build web`
6. Set publish directory: `build/web`
7. Deploy (automatic)

**Your app will be live at:** `random-name.netlify.app`

### Firebase Hosting
1. Install Firebase CLI: `npm install -g firebase-tools`
2. Login: `firebase login`
3. Initialize: `firebase init hosting`
4. Deploy: `firebase deploy --only hosting`
5. Your URL: `your-project.web.app`

### Vercel
1. Go to [vercel.com](https://vercel.com)
2. Sign in with GitHub
3. Import your repository
4. Configure:
   - Framework: Other
   - Build command: `flutter build web`
   - Output directory: `build/web`
5. Deploy

---

## 📦 Offline Support (PWA)

Your app works offline thanks to:
- **Service Worker** (`flutter_service_worker.js`)
- **Web App Manifest** (`manifest.json`)

Users can use the app even without internet (cached content).

---

## 🛠️ Troubleshooting

### App not loading after deploy
- Clear browser cache (Ctrl+Shift+Delete)
- Hard refresh (Ctrl+Shift+R or Cmd+Shift+R)
- Check browser console for errors

### Asset paths broken
- Ensure `pubspec.yaml` has assets configured
- Rebuild: `flutter clean && flutter build web`

### CORS errors
- Use Netlify or Vercel (they handle CORS automatically)
- If self-hosting, configure CORS headers on your server

---

## 📋 Current Build Info

**Built:** November 12, 2025
**Build Type:** Release Web Build
**Location:** `build/web/`
**Size:** ~10-15 MB (optimized)

**Included:**
- ✅ All 7 pages (Home, Mitaq, Mutun, Programs, History, Scholars, Institutions)
- ✅ Mutun detail pages with lessons, videos, downloads
- ✅ Arabic fonts (Cairo, Amiri, Tajawal)
- ✅ RTL support
- ✅ Responsive design
- ✅ Offline support

---

## 🔒 Security Checklist

- [ ] Use HTTPS (all hosting providers support this)
- [ ] Enable CORS headers if needed
- [ ] Add robots.txt for SEO
- [ ] Set up Google Analytics (optional)
- [ ] Regular backups of your repository

---

## 📞 Next Steps

1. **Choose a hosting provider** (Recommended: Netlify for easiest setup)
2. **Deploy your web build**
3. **Share the URL** with users
4. **Monitor analytics** (optional)
5. **Update content** as needed (redeploy automatically)

---

**Questions?** Check Flutter's official deployment guide:
https://flutter.dev/docs/deployment/web

**Happy deploying! 🎉**
