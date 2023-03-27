import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_book/common/helper_functions.dart';
import 'package:photo_book/ui/components/category_tabbar.dart';
import 'package:photo_book/ui/components/image_modal.dart';
import 'package:photo_book/ui/components/masonry_grid.dart';
import 'package:photo_book/ui/providers/photos_filter_provider.dart';
import 'package:photo_book/ui/providers/photos_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'domain/photo.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void onShare(Photo image) {
    Share.shareXFiles([XFile(image.path)],
        subject: image.category, text: 'Mira una imagen de ${image.category}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesProvider = ref.watch(newImageControllerProvider);
    final selectedItem = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          tooltip: 'Agregar Foto',
          onPressed: () {
            ImageModal(
              context: context,
              onImageSelected: (imagePath, category) {
                Navigator.of(context).pop();
                log("el imagePath es $imagePath y la categoria $category");
                ref
                    .read(newImageControllerProvider.notifier)
                    .addImage(imagePath, category);
              },
            );
          },
          child: const Icon(Icons.camera_alt),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mis fotos',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    ref.read(selectedCategoryProvider.notifier).update('');
                  },
                  child: Text(
                    'Ver todos',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            imagesProvider.when(
              data: (images) {
                if (images.isEmpty) {
                  return const Text('No hay imagenes para mostrar');
                }

                final groupedImages =
                    groupBy(images, (image) => image.category);

                final filteredImages =
                    selectedItem.isEmpty ? images : groupedImages[selectedItem];

                return Expanded(
                  child: Column(
                    children: [
                      CategoryTabbar(
                        categories: groupedImages.keys.toList(),
                        selectedItem: selectedItem,
                        onTap: (selectedItem) {
                          ref
                              .read(selectedCategoryProvider.notifier)
                              .update(selectedItem);
                        },
                      ),
                      Expanded(
                        child: MasonryGrid(
                          images: filteredImages!.map((e) => e.path).toList(),
                          onTap: (value) {
                            final selected = filteredImages[value];
                            onShare(selected);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (Object error, StackTrace stackTrace) =>
                  Center(child: Text("Error ${error.toString()}")),
              loading: () => Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Cargando Imagenes',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const CircularProgressIndicator()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
