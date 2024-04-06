part of 'flash_sale_product_bloc.dart';

@freezed
class FlashSaleProductEvent with _$FlashSaleProductEvent {
  const factory FlashSaleProductEvent.started() = _Started;
  const factory FlashSaleProductEvent.getFlashSaleProducts() =
      _GetFlashSaleProducts;
}
