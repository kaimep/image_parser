import '../../domain/entities/image_entity.dart';
import '../../domain/repositories/image_repository.dart';
import '../datasources/image_remote_data_source.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource remoteDataSource;

  ImageRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ImageEntity>> parseImagesFromPage(String pageUrl) async {
    return await remoteDataSource.fetchImagesFromPage(pageUrl);
  }
}
