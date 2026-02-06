import '../../domain/entities/image_entity.dart';

class ImageModel {
  final String url;
  final String? alt;

  ImageModel({required this.url, this.alt});

  ImageEntity toEntity() {
    return ImageEntity(url: url, alt: alt);
  }
}
