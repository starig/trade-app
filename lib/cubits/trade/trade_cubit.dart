import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trade_state.dart';

class TradeCubit extends Cubit<TradeState> {
  TradeCubit() : super(TradeState(balance: 10000, investmentCount: 1000));

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
}
