import 'package:dio/dio.dart';
import 'package:locator_sample/model/shoplistresponse.dart';

class MarketPlaceRepository {
  static final BaseOptions _baseOptions =
  BaseOptions(baseUrl:"http://41.76.108.115/");

  Dio dio = Dio(_baseOptions);


  Future<List<Art>> getArts() async {
    List<Art> _art = [];

    try {
      final response = await dio.get("file/get_image");

      var data = response.data as List;
      print(data);
      data.forEach((data) {

        _art.add(Art.fromMap(data));
      });

      return _art;
    } on DioError catch (e) {
      throw e.response!.data['message'];
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<String> shopListDetail() async {
    try {
      final response = await dio.get("on_sale_locator/validate_shop?shop_id=1234");
      return response.data['message'];
    } on DioError catch (e) {
      throw e.response!.data['message'];
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

}