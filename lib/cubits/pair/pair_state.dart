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
  List<TradingViewSymbol> allPairs;

  PairState({required this.chosenPair, required this.allPairs});

  PairState copyWith({TradingViewSymbol? chosenPair, List<TradingViewSymbol>? allPairs}) {
    return PairState(
      chosenPair: chosenPair ?? this.chosenPair,
      allPairs: allPairs ?? this.allPairs
    );
  }
}
