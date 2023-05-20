import 'package:bloc/bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'pair_state.dart';

class PairCubit extends Cubit<PairState> {
  PairCubit() : super(PairState(chosenPair: TradingViewSymbol.AAPL));

  setChosenPair(TradingViewSymbol value) {
    state.chosenPair = value;
    emit(state.copyWith(chosenPair: state.chosenPair));
  }
}
