import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testing_aplikasi/data/datasources/product_remote_datasource.dart';

import '../../../../data/models/responses/product_response_model.dart';

part 'best_seller_product_bloc.freezed.dart';
part 'best_seller_product_event.dart';
part 'best_seller_product_state.dart';

class BestSellerProductBloc
    extends Bloc<BestSellerProductEvent, BestSellerProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  BestSellerProductBloc(this._productRemoteDatasource)
      : super(const _Initial()) {
    on<_GetBestSellerProducts>((event, emit) async {
      final response = await _productRemoteDatasource.getProductByCategory(6);
      response.fold(
          (l) => emit(const BestSellerProductState.error(
              'Internal Server Error Best Seller Product')),
          (r) => emit(BestSellerProductState.loaded(r.data!.data!)));
    });
  }
}
