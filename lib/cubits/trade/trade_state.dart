part of 'trade_cubit.dart';

class Timer {
  int minutes;
  int seconds;

  Timer({required this.minutes, required this.seconds});
}

class TradeState {
  int balance;
  int investmentCount;
  Timer timer;

  TradeState(
      {required this.balance,
      required this.investmentCount,
      required this.timer});

  TradeState copyWith({int? balance, int? investmentCount, Timer? timer}) {
    return TradeState(
      balance: balance ?? this.balance,
      investmentCount: investmentCount ?? this.investmentCount,
      timer: timer ?? this.timer,
    );
  }
}
