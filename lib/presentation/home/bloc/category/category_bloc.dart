// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/datasources/category_remote_datasource.dart';
import '../../../../data/models/responses/category_response_model.dart';
part 'category_bloc.freezed.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRemoteDatasource _categoryRemoteDatasource;
  CategoryBloc(
    this._categoryRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetCategories>((event, emit) async {
      final response = await _categoryRemoteDatasource.getCategories();
      response.fold(
          (l) =>
              emit(const CategoryState.error('Internal Server Error Category')),
          (r) => emit(CategoryState.loaded(r.data!)));
    });
  }
}
