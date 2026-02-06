import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_invest/domain/entities/image_entity.dart';
import 'package:test_invest/domain/repositories/image_repository.dart';
import 'package:test_invest/domain/usecases/parse_image_from_page.dart';

class MockImageRepository extends Mock implements ImageRepository {}

void main() {
  late MockImageRepository mockRepository;
  late ParseImagesFromPage useCase;

  setUp(() {
    mockRepository = MockImageRepository();
    useCase = ParseImagesFromPage(mockRepository);
  });

  final tUrl = 'https://books.toscrape.com/';
  final tImages = [
    ImageEntity(
      url: 'https://books.toscrape.com/media/image1.jpg',
      alt: 'Книга 1',
    ),
    ImageEntity(
      url: 'https://books.toscrape.com/media/image2.jpg',
      alt: 'Книга 2',
    ),
  ];

  test(
    'должен вернуть список изображений при успешном вызове репозитория',
    () async {
      when(
        () => mockRepository.parseImagesFromPage(tUrl),
      ).thenAnswer((_) async => tImages);
      final result = await useCase.call(tUrl);
      expect(result, tImages);
      verify(() => mockRepository.parseImagesFromPage(tUrl)).called(1);
    },
  );

  test('должен выбросить исключение если репозиторий выбрасывает', () async {
    when(
      () => mockRepository.parseImagesFromPage(tUrl),
    ).thenThrow(Exception('Ошибка сети'));
    expect(() => useCase.call(tUrl), throwsA(isA<Exception>()));
  });
}
