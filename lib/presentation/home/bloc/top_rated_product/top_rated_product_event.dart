part of 'top_rated_product_bloc.dart';

@freezed
class TopRatedProductEvent with _$TopRatedProductEvent {
  const factory TopRatedProductEvent.started() = _Started;
  const factory TopRatedProductEvent.TopRatedProducts() = _TopRatedProducts;
}
