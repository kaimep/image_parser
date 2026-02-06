import 'package:flutter/material.dart';
import '../../domain/entities/image_entity.dart';

class ImageItemWidget extends StatelessWidget {
  final ImageEntity image;

  const ImageItemWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            image.url,
            height: 150,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(
                height: 150,
                child: Center(child: Text('Не удалось загрузить изображение')),
              );
            },
          ),
          const SizedBox(height: 5),
          Text('URL: ${image.url}'),
          if (image.alt != null) Text('Alt: ${image.alt}'),
          const Divider(),
        ],
      ),
    );
  }
}
