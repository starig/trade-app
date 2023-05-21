part of 'trade_cubit.dart';

class TradeState {
  int balance;
  int investmentCount;

  TradeState({required this.balance, required this.investmentCount});

  TradeState copyWith({int? balance, int? investmentCount}) {
    return TradeState(balance: balance ?? this.balance, investmentCount: investmentCount ?? this.investmentCount);
  }
}

