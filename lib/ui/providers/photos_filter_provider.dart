import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photos_filter_provider.g.dart';

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  String build() {
    return '';
  }

  void update(String category) {
    state = category;
  }
}
