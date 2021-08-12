import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';

void main() {
  group('Outline Text Field', () {
    testWidgets('Find Widget, initial Value and Type "Hi" ',
        (WidgetTester tester) async {
      final String initialValue = 'initial value';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OutlineTextField(initialValue: initialValue),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      TextFormField textFormField =
          find.byType(TextFormField).evaluate().first.widget as TextFormField;
      expect(textFormField.initialValue, initialValue);

      await tester.enterText(find.byType(TextFormField), 'Hi');
      expect(find.text('Hi'), findsOneWidget);
    });

    testWidgets('Pass Controller to OutlineTextField',
        (WidgetTester tester) async {
      final TextEditingController controller =
          TextEditingController(text: 'pass controller');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OutlineTextField(
              textEditingController: controller,
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      TextFormField textFormField =
          find.byType(TextFormField).evaluate().first.widget as TextFormField;
      expect(textFormField.controller, controller);
      expect(find.text('pass controller'), findsOneWidget);
    });

    testWidgets('Pass Enable true and false in OutlineTextField',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OutlineTextField(
              enabled: true,
            ),
          ),
        ),
      );

      TextFormField textFormFieldTrue =
          find.byType(TextFormField).evaluate().first.widget as TextFormField;
      expect(find.byType(TextFormField), findsOneWidget);
      expect(textFormFieldTrue.enabled, isTrue);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OutlineTextField(
              enabled: false,
            ),
          ),
        ),
      );

      TextFormField textFormFieldFalse =
          find.byType(TextFormField).evaluate().first.widget as TextFormField;
      expect(find.byType(TextFormField), findsOneWidget);
      expect(textFormFieldFalse.enabled, isFalse);
    });

    testWidgets('Pass onChange callback is called',
        (WidgetTester tester) async {
      String? _value;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OutlineTextField(
              onChanged: (val) {
                _value = val;
              },
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(_value, isNull);

      Future<void> checkText(String testValue) async {
        await tester.enterText(find.byType(TextField), testValue);
        expect(_value, equals(testValue));
      }

      await checkText('Test');
      await checkText('testValue');
    });

    testWidgets('Pass onSaved callback is called', (WidgetTester tester) async {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      String? _value;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: OutlineTextField(
                onSaved: (val) {
                  _value = val!;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(_value, isNull);

      Future<void> checkText(String testValue) async {
        await tester.enterText(find.byType(TextFormField), testValue);
        formKey.currentState?.save();
        expect(_value, equals(testValue));
      }

      await checkText('Test');
      await checkText('testValue');
    });

    testWidgets('Pass multiLine (maxLines)', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OutlineTextField(
              initialValue: 'testValue',
              isMultiLine: true,
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);

      final EditableText formFieldTrue =
          tester.widget<EditableText>(find.text('testValue'));
      expect(formFieldTrue.maxLines, null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OutlineTextField(
              initialValue: 'testValue',
              isMultiLine: false,
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);

      final EditableText formFieldFalse =
          tester.widget<EditableText>(find.text('testValue'));
      expect(formFieldFalse.maxLines, 1);
    });
  });

  group('Text Field Counter', () {
    testWidgets('Increment', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldCounter(
              value: 1,
            ),
          ),
        ),
      );

      expect(find.byType(OutlineTextField), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add_rounded));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add_rounded));
      await tester.pump();
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('Decrement', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldCounter(
              value: 3,
            ),
          ),
        ),
      );

      expect(find.byType(OutlineTextField), findsOneWidget);

      await tester.tap(find.byIcon(Icons.remove_rounded));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.remove_rounded));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });
  });

  group('Text Field With Expansion View', () {
    testWidgets('Find Widget and Type "Hi" ', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldWithExpansionView(
              expansionTitle: 'Expansion',
              labelText: 'Expansion',
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'Hi');
      expect(find.text('Hi'), findsOneWidget);
    });

    testWidgets('Expansion Click to Show and Hide Expansion Children',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldWithExpansionView(
              expansionTitle: 'Expansion',
              labelText: 'Expansion',
              expansionChildren: [Text('After Expand')],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.expand_more), findsOneWidget);

      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();
      expect(find.text('After Expand'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();
      expect(find.text('After Expand'), findsNothing);
    });
  });
}
