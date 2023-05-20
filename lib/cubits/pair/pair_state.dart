part of 'pair_cubit.dart';

enum TradingViewSymbol {
  AAPL,
  GOOGL,
  MSFT,
  AMZN,
  TSLA,
  FB,
  NVDA,
  BABA,
  JPM,
  JNJ,
  V,
  WMT,
  BAC,
  XOM,
  SPX
}

class PairState {
  TradingViewSymbol chosenPair;

  PairState({required this.chosenPair});

  PairState copyWith({TradingViewSymbol? chosenPair}) {
    return PairState(
      chosenPair: chosenPair ?? this.chosenPair,
    );
  }
}
