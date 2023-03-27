Map<K, List<V>> groupBy<K, V>(List<V> list, K Function(V) keySelector) {
  Map<K, List<V>> result = {};
  for (var item in list) {
    K key = keySelector(item);
    if (!result.containsKey(key)) {
      result[key] = [];
    }
    result[key]?.add(item);
  }
  return result;
}
