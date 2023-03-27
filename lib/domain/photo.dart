import 'package:flutter/foundation.dart';

@immutable
class Photo {
  final String id;
  final String path;
  final String category;

  const Photo({
    required this.id,
    required this.path,
    required this.category,
  });
}
