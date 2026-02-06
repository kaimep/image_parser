import 'package:flutter/material.dart';
import 'domain/usecases/parse_image_from_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/state/image_cubit.dart';
import 'data/datasources/image_remote_data_source.dart';
import 'data/repositories/image_repository_impl.dart';

void main() {
  final remoteDataSource = ImageRemoteDataSourceImpl();
  final repository = ImageRepositoryImpl(remoteDataSource);
  final useCase = ParseImagesFromPage(repository);
  final cubit = ImageCubit(useCase);

  runApp(MyApp(imageCubit: cubit));
}

class MyApp extends StatelessWidget {
  final ImageCubit imageCubit;

  const MyApp({super.key, required this.imageCubit});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Парсер изображений',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(imageCubit: imageCubit),
    );
  }
}
