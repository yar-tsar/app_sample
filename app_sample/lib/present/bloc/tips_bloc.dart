import 'package:app_sample/present/bloc/tips_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TipsCubit extends Cubit<TipsState> {
  TipsCubit() : super(TipsState.initial());

  void setSliderPercetage(int value) {
    emit(
      state.copyWith(
        percent: value,
      ),
    );
  }
}
