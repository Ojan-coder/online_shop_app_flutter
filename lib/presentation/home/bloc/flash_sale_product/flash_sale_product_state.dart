part of 'flash_sale_product_bloc.dart';

@freezed
class FlashSaleProductState with _$FlashSaleProductState {
  const factory FlashSaleProductState.initial() = _Initial;
  const factory FlashSaleProductState.loading() = _Loading;
  const factory FlashSaleProductState.loaded(List<Product> products) = _Loaded;
  const factory FlashSaleProductState.error(String message) = _Error;
}
