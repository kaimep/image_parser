import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/image_cubit.dart';
import '../state/image_state.dart';
import '../widgets/image_item_widget.dart';

class HomePage extends StatefulWidget {
  final ImageCubit imageCubit;

  const HomePage({super.key, required this.imageCubit});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController urlController = TextEditingController(
    text: 'https://books.toscrape.com/',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Парсер изображений')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: urlController,
              decoration: const InputDecoration(labelText: 'URL страницы'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                widget.imageCubit.loadImages(urlController.text);
              },
              child: const Text('Загрузить'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ImageCubit, ImageState>(
                bloc: widget.imageCubit,
                builder: (context, state) {
                  if (state is ImageInitial) {
                    return const Center(child: Text('Введите URL и загрузите изображения'));
                  } else if (state is ImageLoading) {
                    return const Center(child: CupertinoActivityIndicator(
                      radius: 20,
                      color: CupertinoColors.activeBlue,
                    ));
                  } else if (state is ImageLoaded) {
                    return ListView.builder(
                      itemCount: state.images.length,
                      itemBuilder: (context, index) {
                        return ImageItemWidget(image: state.images[index]);
                      },
                    );
                  } else if (state is ImageError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
