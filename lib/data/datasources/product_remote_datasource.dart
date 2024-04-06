import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:testing_aplikasi/core/constants/variables.dart';
import 'package:testing_aplikasi/data/models/responses/product_response_model.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getAllProducts() async {
    final response =
        await http.get(Uri.parse('${Variables.baseUrl}/api/products'));

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Internal Server Error Products');
    }
  }

  Future<Either<String, ProductResponseModel>> getProductByCategory(
      int categoryId) async {
    final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/products?category_id=$categoryId'));

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Internal Server Error Products');
    }
  }
}
