# 🎥 Flick TV OTT – Flutter App Prototype

A **modern OTT video streaming application prototype** built entirely with **Flutter**, inspired by popular streaming platforms like **Netflix** and **Amazon Prime Video**.  

This project demonstrates clean architecture, scalable code organization, and functional video playback — all wrapped in a sleek, intuitive UI.

---

## ✨ Features Implemented

### 🏠 **Netflix-Style Home Screen**
- Dynamic, scrollable layout.
- Prominent **hero banner** for featured content.
- Multiple **horizontally scrolling carousels** for different categories (Trending, Action, Suspense, etc.).

### 📄 **Content Details Page**
- Detailed view with:
  - Year, rating, duration, and description.
  - **“Play”** and **“Add to List”** actions.
  - “More Like This” recommendation grid.

### 🎬 **Integrated Video Player**
- Powered by **Chewie** and **Video Player** packages.
- Fullscreen immersive playback.
- **Reels-style vertical swipe** navigation between videos.
- **Landscape mode** playback by default.
- **Custom exit logic**: automatically returns to portrait and previous screen when closed.

### 🧭 **Advanced Navigation**
- Bottom navigation bar with **Home**, **Movies**, and **Profile**.
- Auto-hide on scroll for immersive browsing.
- Custom back-button behavior: always returns to Home before exiting.

### ⚡ **Performance Optimization**
- **Cached thumbnails** via `cached_network_image` for faster load times and offline availability.
- Smooth scrolling and lazy loading.
- Release-ready with all necessary **permissions** and **network configurations**.

---

## 🧱 Architecture & State Management

Flick TV OTT follows **Clean Architecture** principles, organized into three core layers:

| Layer | Responsibility |
|-------|----------------|
| **Presentation** | UI widgets, pages, BLoCs |
| **Domain** | Business logic, entities, use cases |
| **Data** | Data sources (local JSON or APIs) |

State management is powered by **BLoC (Business Logic Component)** ensuring predictable, reactive UI updates.

---

## 🧩 Technologies & Key Packages

| Purpose | Package |
|----------|----------|
| Framework | Flutter |
| State Management | `flutter_bloc`, |
| Video Playback | `video_player`, `chewie` |
| Image Caching | `cached_network_image` |
| Functional Programming | `dartz` |
| Code Generation | `json_serializable`, `build_runner` |
| Equality | `equatable` |
| Testing | `mocktail` |

---

## ⚙️ Setup & Installation


### 🔧 Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Android Studio / VS Code
- Android Emulator or Physical Device

---

### 🧭 1. Clone the Repository

```bash
git clone https://github.com/strivepawan/flick-TV-OTT.git
cd flick_tv_ott



apk
Drive link 
https://drive.google.com/file/d/11ejp3myOJ2BQ1INhS3xTjIfHDep9C_4z/view?usp=sharing