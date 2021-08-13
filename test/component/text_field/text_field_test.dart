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

      //Verify widget and Initial Value
      expect(find.byType(TextFormField), findsOneWidget);
      TextFormField textFormField =
          find.byType(TextFormField).evaluate().first.widget as TextFormField;
      expect(textFormField.initialValue, initialValue);

      //Type some text to text field and Verify
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

      //Verify controller
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

      //Verify text field if enable
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

      //Verify text field if disable
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

      //Verify TextFormField and onChange Value
      expect(find.byType(TextFormField), findsOneWidget);
      expect(_value, isNull);

      Future<void> checkText(String testValue) async {
        await tester.enterText(find.byType(TextField), testValue);
        expect(_value, equals(testValue));
      }

      //Verify newValue in onChange method
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

      //Verify TextFormField and onSaved Value
      expect(find.byType(TextFormField), findsOneWidget);
      expect(_value, isNull);

      Future<void> checkText(String testValue) async {
        await tester.enterText(find.byType(TextFormField), testValue);
        formKey.currentState?.save();
        expect(_value, equals(testValue));
      }

      //Verify newValue in onSaved method
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

      //Verify Widget and multiLines enable
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

      //Verify Widget and multiLines disable
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

      //Verify Widget
      expect(find.byType(OutlineTextField), findsOneWidget);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add_rounded));
      await tester.pump();

      // Verify that our counter has incremented.
      expect(find.text('1'), findsNothing);
      expect(find.text('2'), findsOneWidget);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add_rounded));
      await tester.pump();

      // Verify that our counter has incremented.
      expect(find.text('2'), findsNothing);
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

      //Verify Widget
      expect(find.byType(OutlineTextField), findsOneWidget);

      // Tap the '-' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.remove_rounded));
      await tester.pump();

      // Verify that our counter has decremented.
      expect(find.text('3'), findsNothing);
      expect(find.text('2'), findsOneWidget);

      // Tap the '-' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.remove_rounded));
      await tester.pump();

      // Verify that our counter has decremented.
      expect(find.text('2'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    });
  });

  group('Text Field With Expansion View', () {
    testWidgets('Find Widget and Type "Hi" ', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldWithExpansionView(
              expansionTitle: 'Expansion Title',
              labelText: 'Expansion Label',
            ),
          ),
        ),
      );

      //Verify TextFormField in TextFieldWithExpansionView
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Expansion Label'), findsOneWidget);

      //Type newValue to TextFormField
      await tester.enterText(find.byType(TextFormField), 'Hi');

      //Verify TextFormField with newValue
      expect(find.text('Hi'), findsOneWidget);
    });

    testWidgets('Expansion Click to Show and Hide Expansion Children',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldWithExpansionView(
              expansionTitle: 'Expansion Title',
              labelText: 'Expansion Label',
              expansionChildren: [Text('After Expand')],
            ),
          ),
        ),
      );

      //Verify Expansion Widget
      expect(find.text('Expansion Title'), findsOneWidget);
      expect(find.byIcon(Icons.expand_more), findsOneWidget);

      //Tap expansion icon to show expand child
      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();

      //Verify Expansion after expand
      expect(find.text('After Expand'), findsOneWidget);

      //Tap expansion icon to hide expand child
      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();

      //Verify expansion after unExpand
      expect(find.text('After Expand'), findsNothing);
    });
  });
}
