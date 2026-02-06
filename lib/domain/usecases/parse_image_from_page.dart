import '../entities/image_entity.dart';
import '../repositories/image_repository.dart';

class ParseImagesFromPage {
  final ImageRepository imageRepository;

  ParseImagesFromPage(this.imageRepository);

  Future<List<ImageEntity>> call(String pageUrl) {
    return imageRepository.parseImagesFromPage(pageUrl);
  }
}
