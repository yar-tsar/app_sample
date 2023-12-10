class TipsState {
  final String fieldValue;
  final String amount;
  final List<String> tips;
  final int percent;

  TipsState({
    required this.fieldValue,
    required this.tips,
    required this.amount,
    required this.percent,
  });

  factory TipsState.initial() {
    return TipsState(
      fieldValue: '',
      amount: '',
      tips: [],
      percent: 0,
    );
  }

  TipsState copyWith({
    int? percent,
    String? fieldValue,
    String? amount,
    List<String>? tips,
  }) {
    return TipsState(
      fieldValue: fieldValue ?? this.fieldValue,
      amount: amount ?? this.amount,
      tips: tips ?? this.tips,
      percent: percent ?? this.percent,
    );
  }
}
