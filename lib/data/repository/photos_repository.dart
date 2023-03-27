import 'package:photo_book/data/mappers/photo_mapper.dart';
import 'package:photo_book/data/services/storage/photos_db.dart';
import 'package:photo_book/domain/gateways/photo_gateway.dart';
import 'package:photo_book/domain/photo.dart';

class PhotosRepository implements PhotoGateway {
  late final PhotoMapper _mapper;
  final PhotosDb api;

  PhotosRepository(this.api) {
    _mapper = PhotoMapper();
  }

  @override
  Future<void> saveImage(Photo photo) async {
    final photoMap = _mapper.toMap(photo);
    await api.saveImage(photoMap);
  }

  @override
  Future<List<Photo>> getImages() async {
    final response = await api.getImages();
    return response
        .map(
          (image) => _mapper.fromMap(image.cast<String, dynamic>()),
        )
        .toList();
  }
}
