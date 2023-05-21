part of 'app_cubit.dart';

class AppState {
  double loadingProgress;
  bool showBottomNavbar;
  bool isLoaded;
  bool isPairChanged;

  AppState(
      {required this.loadingProgress,
      required this.showBottomNavbar,
      required this.isLoaded,
      required this.isPairChanged});

  AppState copyWith(
      {double? loadingProgress,
      bool? showBottomNavbar,
      bool? isLoaded,
      bool? isPairChanged}) {
    return AppState(
      loadingProgress: loadingProgress ?? this.loadingProgress,
      showBottomNavbar: showBottomNavbar ?? this.showBottomNavbar,
      isLoaded: isLoaded ?? this.isLoaded,
      isPairChanged: isPairChanged ?? this.isPairChanged,
    );
  }
}
