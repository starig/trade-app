part of 'pair_cubit.dart';

enum TradingViewSymbol {
  AAPL,
  GOOGL,
  MSFT,
  AMZN,
  TSLA,
  FB,
  NVDA,
  COIN,
  PYPL,
  ABNB,
}

class PairState {
  TradingViewSymbol chosenPair;

  PairState({
    required this.chosenPair,
  });

  PairState copyWith({TradingViewSymbol? chosenPair}) {
    return PairState(
      chosenPair: chosenPair ?? this.chosenPair,
    );
  }
}
