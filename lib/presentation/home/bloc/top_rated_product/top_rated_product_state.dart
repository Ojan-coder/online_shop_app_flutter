part of 'top_rated_product_bloc.dart';

@freezed
class TopRatedProductState with _$TopRatedProductState {
  const factory TopRatedProductState.initial() = _Initial;
  const factory TopRatedProductState.loading() = _Loading;
  const factory TopRatedProductState.loaded(List<Product> products) = _Loaded;
  const factory TopRatedProductState.error(String message) = _Error;
}
