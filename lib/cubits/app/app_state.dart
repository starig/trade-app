part of 'app_cubit.dart';

class AppState {
  double loadingProgress;
  bool showBottomNavbar;
  bool isLoaded;

  AppState({required this.loadingProgress, required this.showBottomNavbar, required this.isLoaded});

  AppState copyWith({double? loadingProgress, bool? showBottomNavbar, bool? isLoaded}) {
    return AppState(
      loadingProgress: loadingProgress ?? this.loadingProgress,
      showBottomNavbar: showBottomNavbar ?? this.showBottomNavbar,
      isLoaded: isLoaded ?? this.isLoaded
    );
  }
}
