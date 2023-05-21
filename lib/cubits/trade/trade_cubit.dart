import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trade_state.dart';

class TradeCubit extends Cubit<TradeState> {
  TradeCubit()
      : super(
          TradeState(
            balance: 10000,
            investmentCount: 1000,
            timer: Timer(minutes: 0, seconds: 10),
          ),
        );

  increaseInvestmentCount() {
    if (state.investmentCount + 100 <= state.balance) {
      state.investmentCount += 100;
      emit(state.copyWith(investmentCount: state.investmentCount));
    }
  }

  decreaseInvestmentCount() {
    if (state.investmentCount - 100 >= 0) {
      state.investmentCount -= 100;
      emit(state.copyWith(investmentCount: state.investmentCount));
    }
  }

  setInvestmentCount(String value) {
    int newValue = int.parse(value);
    if (state.balance > newValue) {
      state.investmentCount = newValue;
      emit(state.copyWith(investmentCount: state.investmentCount));
    }
  }

  setTimerCount(Timer timer) {
    state.timer = timer;
    emit(state.copyWith(timer: state.timer));
  }

  decreaseSeconds() {
    if (!(state.timer.seconds == 0 && state.timer.minutes == 0)) {
      if (state.timer.seconds == 0) {
        state.timer.minutes -= 1;
        state.timer.seconds = 59;
      } else {
        state.timer.seconds -= 1;
      }
      emit(state.copyWith(timer: state.timer));
    }
  }

  increaseSeconds() {
    if (state.timer.seconds == 59) {
      state.timer.seconds = 0;
      state.timer.minutes += 1;
    } else {
      state.timer.seconds += 1;
    }
    emit(state.copyWith(timer: state.timer));
  }
}
