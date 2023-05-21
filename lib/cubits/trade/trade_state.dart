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
  bool isPending;

  TradeState(
      {required this.balance,
      required this.investmentCount,
      required this.timer, required this.isPending});

  TradeState copyWith({int? balance, int? investmentCount, Timer? timer, bool? isPending}) {
    return TradeState(
      balance: balance ?? this.balance,
      investmentCount: investmentCount ?? this.investmentCount,
      timer: timer ?? this.timer,
      isPending: isPending ?? this.isPending
    );
  }
}
