part of 'trade_cubit.dart';

class TradeState {
  int balance;

  TradeState({required this.balance});

  TradeState copyWith({int? balance}) {
    return TradeState(balance: balance ?? this.balance);
  }
}

