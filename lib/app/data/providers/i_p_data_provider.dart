import 'package:get/get.dart';

import '../models/i_p_data_model.dart';

class IPDataProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return IPData.fromJson(map);
      if (map is List) return map.map((item) => IPData.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'http://ip-api.com/';
  }

  Future<IPData?> getIPData() async {
    final response = await get('json');
    return response.body;
  }
}
