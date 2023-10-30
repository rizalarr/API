import 'package:pertemuan5/BaseNetwork.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadUsers() {
return BaseNetwork.get("users");
}

  loadDetaiUser(int idUser) {}

}