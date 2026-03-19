import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniusclaw_app/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: GeniusClawApp(),
      ),
    );
    
    // Verify app loads
    expect(find.text('GeniusClaw'), findsOneWidget);
  });
}