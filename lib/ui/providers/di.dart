import 'package:photo_book/data/repository/photos_repository.dart';
import 'package:photo_book/data/services/storage/photos_db.dart';
import 'package:photo_book/domain/use_cases/photos_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'di.g.dart';

@riverpod
PhotosDb photosDb(PhotosDbRef ref) {
  return PhotosDb();
}

@riverpod
PhotosRepository photosRepository(PhotosRepositoryRef ref) {
  return PhotosRepository(ref.watch(photosDbProvider));
}

@riverpod
PhotosUseCase photosUseCase(PhotosUseCaseRef ref) {
  return PhotosUseCase(ref.watch(photosRepositoryProvider));
}
