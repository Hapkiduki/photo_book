import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MasonryGrid extends StatelessWidget {
  const MasonryGrid({
    super.key,
    required this.images,
    this.onTap,
  });

  final List<String> images;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          onTap?.call(index);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            File(images[index]),
            fit: BoxFit.cover,
          ),
        ),
      ),
      gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }
}
