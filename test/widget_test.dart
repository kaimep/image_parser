// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_invest/data/datasources/image_remote_data_source.dart';
import 'package:test_invest/data/repositories/image_repository_impl.dart';
import 'package:test_invest/domain/usecases/parse_image_from_page.dart';

import 'package:test_invest/main.dart';
import 'package:test_invest/presentation/state/image_cubit.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final remoteDataSource = ImageRemoteDataSourceImpl();
    final repository = ImageRepositoryImpl(remoteDataSource);
    final useCase = ParseImagesFromPage(repository);
    final cubit = ImageCubit(useCase);

    await tester.pumpWidget(MyApp(imageCubit: cubit));


    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
