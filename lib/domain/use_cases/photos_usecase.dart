import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_book/domain/gateways/photo_gateway.dart';
import 'package:photo_book/domain/photo.dart';

class PhotosUseCase {
  final PhotoGateway _photoGateway;

  const PhotosUseCase(this._photoGateway);

  Future<void> saveImage(Photo photo) async =>
      await _photoGateway.saveImage(photo);

  Future<List<Photo>> getImages() => _photoGateway.getImages();
}
