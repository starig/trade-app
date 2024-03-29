import 'package:bloc/bloc.dart';

part 'pair_state.dart';

class PairCubit extends Cubit<PairState> {
  PairCubit()
      : super(PairState(
          chosenPair: TradingViewSymbol.TSLA,
        ));

  setChosenPair(TradingViewSymbol value) {
    state.chosenPair = value;
    emit(state.copyWith(chosenPair: state.chosenPair));
  }
}
