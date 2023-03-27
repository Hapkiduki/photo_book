import 'package:photo_book/data/mappers/base_map.dart';
import 'package:photo_book/domain/photo.dart';

class PhotoMapper extends BaseMapper<Photo> {
  @override
  Photo fromMap(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      path: json['path'],
      category: json['category'],
    );
  }

  @override
  Map<String, dynamic> toMap(Photo data) => {
        'id': data.id,
        'path': data.path,
        'category': data.category,
      };
}
