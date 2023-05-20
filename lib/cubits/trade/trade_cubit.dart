import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trade_state.dart';

class TradeCubit extends Cubit<TradeState> {
  TradeCubit() : super(TradeState(balance: 10000));
}
