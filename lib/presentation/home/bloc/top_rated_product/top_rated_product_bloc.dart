import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:testing_aplikasi/data/datasources/product_remote_datasource.dart';

import '../../../../data/models/responses/product_response_model.dart';

part 'top_rated_product_event.dart';
part 'top_rated_product_state.dart';
part 'top_rated_product_bloc.freezed.dart';

class TopRatedProductBloc
    extends Bloc<TopRatedProductEvent, TopRatedProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  TopRatedProductBloc(this._productRemoteDatasource) : super(const _Initial()) {
    on<TopRatedProductEvent>((event, emit) async {
      final response = await _productRemoteDatasource.getProductByCategory(7);
      response.fold(
          (l) => emit(const TopRatedProductState.error(
              'Internal Server Error Top Rated Products')),
          (r) => emit(TopRatedProductState.loaded(r.data!.data!)));
    });
  }
}
