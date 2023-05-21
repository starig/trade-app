import 'dart:math';

import 'package:bloc/bloc.dart';

part 'trade_state.dart';

class TradeCubit extends Cubit<TradeState> {
  TradeCubit()
      : super(
          TradeState(
            balance: 10000,
            investmentCount: 1000,
            timer: Timer(minutes: 0, seconds: 10),
            isPending: false,
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

  sell() {
    state.isPending = true;
    emit(state.copyWith(isPending: state.isPending));
    Future.delayed(Duration(seconds: 1), () {
      state.balance += state.investmentCount;
      state.investmentCount = (state.balance / 100 * 10).floor();
      state.isPending = false;
      emit(state.copyWith(
        balance: state.balance,
        investmentCount: state.investmentCount,
        isPending: state.isPending,
      ));
    });
  }

  bool buy() {
    state.isPending = true;
    emit(state.copyWith(isPending: state.isPending));
    Random random = Random();
    int randomNumber = random.nextInt(2) + 1;
    if (randomNumber == 1) {
      Future.delayed(Duration(seconds: 1), () {
        state.balance -= (state.investmentCount / 100 * 70).floor();
        state.investmentCount = (state.balance / 100 * 10).floor();
        state.isPending = false;
        emit(state.copyWith(
          balance: state.balance,
          investmentCount: state.investmentCount,
          isPending: state.isPending,
        ));
      });
      return true;
    } else {
      Future.delayed(Duration(seconds: 1), () {
        state.balance -= state.investmentCount;
        state.investmentCount = (state.balance / 100 * 10).floor();
        state.isPending = false;
        emit(state.copyWith(
          balance: state.balance,
          investmentCount: state.investmentCount,
          isPending: state.isPending,
        ));
      });
      return false;
    }
  }
}
