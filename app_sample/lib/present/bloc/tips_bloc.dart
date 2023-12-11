import 'package:app_sample/present/bloc/tips_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TipsCubit extends Cubit<TipsState> {
  TipsCubit() : super(TipsState.initial());

  void setSliderPercentage(double newPercent) {
    emit(
      state.copyWith(percent: newPercent),
    );
  }

  void updateFieldValue(String newValue) {
    emit(
      state.copyWith(fieldValue: newValue),
    );
  }

  void calculateAmount() {
    final int parsedValue = int.tryParse(state.fieldValue) ?? 0;
    emit(
      state.copyWith(
        amount: (parsedValue + (parsedValue * (state.percent / 100))).toString(),
      ),
    );
  }

  void setTips() {
    emit(
      state.copyWith(
        lastBills: state.lastBills..add(state.amount),
      ),
    );
  }
}
