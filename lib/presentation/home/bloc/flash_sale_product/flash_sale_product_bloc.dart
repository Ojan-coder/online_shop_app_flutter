import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testing_aplikasi/data/datasources/product_remote_datasource.dart';

import '../../../../data/models/responses/product_response_model.dart';

part 'flash_sale_product_event.dart';
part 'flash_sale_product_state.dart';
part 'flash_sale_product_bloc.freezed.dart';

class FlashSaleProductBloc
    extends Bloc<FlashSaleProductEvent, FlashSaleProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  FlashSaleProductBloc(this._productRemoteDatasource)
      : super(const _Initial()) {
    on<FlashSaleProductEvent>((event, emit) async {
      final response = await _productRemoteDatasource.getProductByCategory(8);
      response.fold(
          (l) => emit(const FlashSaleProductState.error(
              'Internal Server Error Flash Sale Products')),
          (r) => emit(FlashSaleProductState.loaded(r.data!.data!)));
    });
  }
}
