import 'package:bloc/bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(
    loadingProgress: 0,
    showBottomNavbar: false,
    isLoaded: false
  ));

  setLoadingProgress(double value) {
    state.loadingProgress = value;
    emit(state.copyWith(loadingProgress: state.loadingProgress));
  }

  toggleShowBottomNavbar(bool value) {
    state.showBottomNavbar = value;
    emit(state.copyWith(showBottomNavbar: state.showBottomNavbar));
  }

  setIsLoaded(bool value) {
    state.isLoaded = value;
    emit(state.copyWith(isLoaded: state.isLoaded));
  }
}
