import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_book/domain/photo.dart';

abstract class PhotoGateway {
  Future<void> saveImage(Photo photo);
  Future<List<Photo>> getImages();
}
