class TipsState {
  final String fieldValue;
  final String amount;
  final List<String> lastBills;
  final double percent;

  TipsState({
    required this.fieldValue,
    required this.lastBills,
    required this.amount,
    required this.percent,
  });

  factory TipsState.initial() {
    return TipsState(
      fieldValue: '',
      amount: '',
      lastBills: [],
      percent: 0,
    );
  }

  TipsState copyWith({
    double? percent,
    String? fieldValue,
    String? amount,
    List<String>? lastBills,
  }) {
    return TipsState(
      fieldValue: fieldValue ?? this.fieldValue,
      amount: amount ?? this.amount,
      lastBills: lastBills ?? this.lastBills,
      percent: percent ?? this.percent,
    );
  }
}
