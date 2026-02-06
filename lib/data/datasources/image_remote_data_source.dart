import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import '../../domain/entities/image_entity.dart';

abstract class ImageRemoteDataSource {
  Future<List<ImageEntity>> fetchImagesFromPage(String pageUrl);
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  @override
  Future<List<ImageEntity>> fetchImagesFromPage(String pageUrl) async {
    final uri = Uri.tryParse(pageUrl);
    if (uri == null || !uri.hasScheme) {
      throw Exception('Неверный URL');
    }

    final response = await http.get(uri).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw Exception('Сервер не отвечает');
      },
    );




    final baseUri = response.request!.url;

    final document = html_parser.parse(response.body);
    final imageElements = document.getElementsByTagName('img');

    final Set<String> uniqueUrls = {};
    final List<ImageEntity> images = [];

    for (final element in imageElements) {
      final src = element.attributes['src'];
      if (src == null || src.isEmpty) continue;

      final fullUrl = baseUri.resolve(src).toString();
      if (uniqueUrls.contains(fullUrl)) continue;
      uniqueUrls.add(fullUrl);

      final alt = element.attributes['alt'];

      images.add(ImageEntity(url: fullUrl, alt: alt));
    }

    return images;
  }
}
