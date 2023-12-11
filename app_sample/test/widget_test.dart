import 'package:app_sample/present/bloc/tips_bloc.dart';
import 'package:app_sample/present/bloc/tips_state.dart';
import 'package:app_sample/present/view/calculator_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTipsCubit extends MockCubit<TipsState> implements TipsCubit {}

void main() {
  late TipsCubit cubit;

  group('Unit test', () {
    setUp(() {
      cubit = TipsCubit();
    });

    test('Amount function test', () {
      cubit.setSliderPercentage(10);
      cubit.updateFieldValue('100');
      cubit.calculateAmount();
      expect(cubit.state.amount, '110.0');
    });
  });
  group('Widget test', () {
    setUp(() => {
          cubit = MockTipsCubit(),
        });
    testWidgets('Slider value test', (WidgetTester tester) async {
      when(() => cubit.state).thenReturn(TipsState.initial());

      await tester.pumpWidget(
        BlocProvider.value(
          value: cubit,
          child: const MaterialApp(
            home: CalculatorPage(),
          ),
        ),
      );

      final sliderFinder = find.byType(Slider);
      expect(sliderFinder, findsOneWidget);
      final sliderSize = tester.getSize(sliderFinder);
      //Set size of slider like a max drag distance
      await tester.drag(sliderFinder, Offset(sliderSize.width, 0));

      await tester.pumpAndSettle();
      verify(() => cubit.setSliderPercentage(30)).called(1);
    });
  });

  group('Integration test', () {
    setUp(() => {
          cubit = MockTipsCubit(),
        });
    testWidgets('Calculate flow', (WidgetTester tester) async {
      when(() => cubit.state).thenReturn(TipsState.initial());

      await tester.pumpWidget(
        BlocProvider.value(
          value: cubit,
          child: const MaterialApp(
            home: CalculatorPage(),
          ),
        ),
      );
      //Find text field and enter some text
      final fieldFinder = find.byType(TextField);
      expect(fieldFinder, findsOneWidget);
      await tester.enterText(fieldFinder, '100');
      verify(() => cubit.updateFieldValue('100')).called(1);

      //Find slider and drag it
      final sliderFinder = find.byType(Slider);
      expect(sliderFinder, findsOneWidget);
      final sliderSize = tester.getSize(sliderFinder);
      await tester.drag(sliderFinder, Offset(sliderSize.width, 0));
      await tester.pumpAndSettle();
      verify(() => cubit.setSliderPercentage(30)).called(1);

      //Find button and tap
      final buttonFinder = find.byType(MaterialButton);
      expect(buttonFinder, findsOneWidget);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      //Check two calls to cubit
      verify(() => cubit.state).called(2);
    });
  });
}
