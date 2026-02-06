import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/parse_image_from_page.dart';
import 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final ParseImagesFromPage parseImagesFromPage;

  ImageCubit(this.parseImagesFromPage) : super(ImageInitial());

  Future<void> loadImages(String url) async {
    if (url.isEmpty) {
      emit(ImageError('URL не может быть пустым'));
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) {
      emit(ImageError('Неверный URL'));
      return;
    }

    emit(ImageLoading());

    try {
      final images = await parseImagesFromPage(url);

      if (images.isEmpty) {
        emit(ImageError('Изображения не найдены'));
      } else {
        emit(ImageLoaded(images));
      }
    } on Exception  {
      emit(ImageError('Ошибка сети'));
    }
  }
}
