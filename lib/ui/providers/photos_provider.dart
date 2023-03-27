import 'package:photo_book/domain/photo.dart';
import 'package:photo_book/domain/use_cases/photos_usecase.dart';
import 'package:photo_book/ui/providers/di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photos_provider.g.dart';

@riverpod
class NewImageController extends _$NewImageController {
  late final PhotosUseCase _photosUseCase;

  @override
  FutureOr<List<Photo>> build() {
    _photosUseCase = ref.read(photosUseCaseProvider);
    return getImages();
  }

  Future<void> addImage(String path, String category) async {
    final photo = Photo(
      id: DateTime.now().toIso8601String(),
      path: path,
      category: category,
    );
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _photosUseCase.saveImage(photo);
      return getImages();
    });
  }

  FutureOr<List<Photo>> getImages() async {
    state = const AsyncLoading();
    return await _photosUseCase.getImages();
  }
}
