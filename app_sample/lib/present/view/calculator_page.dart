import 'package:app_sample/present/bloc/tips_bloc.dart';
import 'package:app_sample/present/bloc/tips_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TipsCubit>();
    final theme = Theme.of(context);
    return BlocBuilder<TipsCubit, TipsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.colorScheme.inversePrimary,
            title: const Text('Tips Calculator'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                Text(
                  'Type your bill amount',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    cubit.updateFieldValue(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        '${state.percent}%',
                      ),
                    ],
                  ),
                ),
                Slider(
                  divisions: 30,
                  value: state.percent,
                  onChanged: (value) {
                    cubit.setSliderPercentage(value);
                  },
                  min: 0,
                  max: 30,
                ),
                const SizedBox(height: 8),
                MaterialButton(
                  onPressed: state.percent == 0 || state.fieldValue.isEmpty || state.fieldValue.startsWith('0')
                      ? null
                      : () {
                          cubit.calculateAmount();
                          cubit.setTips();
                        },
                  color: theme.colorScheme.primary,
                  child: const Text('Calculate'),
                ),
                const SizedBox(height: 16),
                state.amount == ''
                    ? const SizedBox.shrink()
                    : Text(
                        'Your total is ${state.amount}',
                        style: theme.textTheme.headlineMedium,
                      ),
                const SizedBox(height: 32),
                state.lastBills.isEmpty
                    ? const SizedBox.shrink()
                    : Text(
                        'Your Last Bills',
                        style: theme.textTheme.bodyMedium,
                      ),
                const SizedBox(height: 16),
                state.lastBills.isEmpty
                    ? const SizedBox.shrink()
                    : Expanded(
                        child: ListView.builder(
                          itemCount: state.lastBills.length,
                          itemBuilder: (context, index) {
                            return Text(
                              state.lastBills[index],
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
