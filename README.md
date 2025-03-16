# 📦 Diamond Filtering & Cart Management App

## Screenshots
Below are some screenshots of the app:

![Page 1](https://github.com/RohitIdeaUsher/kgkdiamonds/blob/main/assets/screenshots/Page1.png)
![Page 2](https://github.com/RohitIdeaUsher/kgkdiamonds/blob/main/assets/screenshots/Page2.png)
![Page 3](https://github.com/RohitIdeaUsher/kgkdiamonds/blob/main/assets/screenshots/Page3.png)
![Page 4](https://github.com/RohitIdeaUsher/kgkdiamonds/blob/main/assets/screenshots/Page4.png)

## Video Demo
Watch the app in action:

[![Watch the Video]](https://github.com/RohitIdeaUsher/kgkdiamonds/blob/main/assets/screenshots/AppVideo.mp4)


## 📜 Project Structure
This Flutter project follows a clean architecture pattern with well-structured layers for state management and UI components.

```
lib/
│── core/
│   ├── common_cubit/
│   │   ├── diamonds/
│   │   │   ├── diamonds_cubit.dart
│   │   │   ├── diamonds_state.dart
│   ├── constant/
│   │   ├── app_images.dart
│   ├── models/
│   │   ├── data.dart
│   │   ├── diamond_data.dart
│   │   ├── filter.dart
│   │   ├── popup_model.dart
│   ├── widgets/
│   │   ├── app_popup.dart
│   │   ├── blink_animation.dart
│   │   ├── cart_icon.dart
│   │   ├── common_button.dart
│   │   ├── diamond_tile.dart
│── features/
│   ├── cart/
│   │   ├── domain/
│   │   │   ├── cart_summary.dart
│   │   ├── presentation/
│   │   │   ├── cubit/
│   │   │   │   ├── cart_cubit.dart
│   │   │   │   ├── cart_state.dart
│   │   │   ├── cart.dart
│   ├── filter/
│   │   ├── presentation/
│   │   │   ├── cubit/
│   │   │   │   ├── filter_cubit.dart
│   │   │   │   ├── filter_state.dart
│   │   │   ├── widget/
│   │   │   │   ├── carat_filter_widget.dart
│   │   ├── filter.dart
│   ├── result/
│   │   ├── presentation/
│   │   │   ├── cubit/
│   │   │   │   ├── result_cubit.dart
│   │   │   │   ├── result_state.dart
│   │   │   ├── widget/
│   │   │   │   ├── filter_button.dart
│   │   │   ├── results.dart
│   ├── splash/
│   │   ├── presentation/
│   │   │   ├── splash.dart
│── main.dart
```

## 🛠 Features
✅ Diamond filtering based on carat, color, clarity, and cut
✅ Cart management with smooth UI
✅ Clean architecture using Cubit for state management
✅ Animated blinking UI effect
✅ Interactive popups and buttons

## 🚀 Installation & Setup
1. Clone the repository:
   ```sh
   git clone YOUR_REPO_URL_HERE
   ```
2. Navigate to the project directory:
   ```sh
   cd diamond_filtering_cart_app
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## 📌 Technologies Used
- Flutter 3.24.0
- Flutter Bloc / Cubit
- Clean Architecture
- Dart

## 🤝 Contributing
Pull requests are welcome! If you have suggestions, feel free to open an issue.

## 📜 License
This project is licensed under the MIT License.

