import 'package:hive/hive.dart';

const String PHOTOS_BOX = 'PhotosBox';

class PhotosDb {
  Future<Box> _openBox() async {
    final box = await Hive.openBox(PHOTOS_BOX);
    return box;
  }

  Future<void> saveImage(Map<String, dynamic> photo) async {
    try {
      final box = await _openBox();
      box.add(photo);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getImages() async {
    try {
      final box = await _openBox();
      return box.values.toList();
    } catch (e) {
      rethrow;
    }
  }
}
