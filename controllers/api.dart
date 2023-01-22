import 'package:dev_mobile_tp/models/dio_mixin.dart';
import 'package:dio/dio.dart';

class Api with ApiDioMixin {
  final dio = ApiDioMixin.dio;

  Future<List<String>> getTables() async {
    List<String> tables = [];
    Response response = await dio.get("/tables");
    if (response.statusCode == 200) {
      response.data["tables"].forEach((element) => {tables.add("$element")});
    } else {
      print("error");
    }
    return tables;
  }

  Future<Map<String, List>> getTable({required tName}) async {
    Map<String, List> table = {"columns": [], "data": []};
    print("this name $tName");
    Response response = await dio.get("/table/$tName");
    print("this code ${response.statusCode}");
    if (response.statusCode == 200) {
      table["columns"] = response.data["col"];
      table["data"] = response.data["data"];
      print("this date ${response.data}");
    } else {
      print("error in get table");
    }
    return table;
  }

  Future<void> updateTable({required Map<String, dynamic> data}) async {
    dynamic uid = data["values"][0];
    Map<String, dynamic> row = {};
    switch (data["name"]) {
      case "etudiant":
        row = {
          "name": data["values"][1],
        };
        break;
      case "module":
        row = {"name": data["values"][1], "coef": data["values"][2]};
        break;
    }

    Response response = await dio.put("/${data["name"]}/$uid", data: row);
    print("this code ${response.statusCode}");
    if (response.statusCode != 200) {
      print("error in get table");
    }
  }

  Future<List<dynamic>> getWorkers() async {
    List<dynamic> workers = [];
    Response response = await dio.get("/workers/");
    print("this code ${response.statusCode}");
    print(" ${response.data}");
    if (response.statusCode == 200) {
      workers = response.data;
    } else {
      print("error in get workers");
    }
    return workers;
  }

  Future<Map<String, dynamic>> getWorker(id) async {
    Map<String, dynamic> worker = {
      "id": "",
      "username": "",
      "phone": "",
      "work_set": [],
      "avatar": "",
    };
    Response response = await dio.get("/workers/$id");
    print("this code ${response.statusCode}");
    print(" ${response.data}");
    if (response.statusCode == 200) {
      worker["id"] = response.data["id"];
      worker["username"] = response.data["username"];
      worker["phone"] = response.data["phone"];
      worker["work_set"] = response.data["work_set"];
      worker["avatar"] = response.data["avatar"];
    } else {
      print("error in get workers");
    }
    return worker;
  }

  Future<Map<String, dynamic>> getWork(String id) async {
    Map<String, dynamic> worker = {
      "id": "",
      "title": "",
      "description": "",
      "image": "",
      "worker": 0,
      "category": 0
    };
    Response response = await dio.get("/works/$id");
    print("this code ${response.statusCode}");
    print(" ${response.data}");
    if (response.statusCode == 200) {
      worker["id"] = response.data["id"];
      worker["title"] = response.data["title"];
      worker["description"] = response.data["description"];
      worker["image"] = response.data["image"];
      worker["worker"] = response.data["worker"];
      worker["category"] = response.data["category"];
    } else {
      print("error in get workers");
    }
    return worker;
  }
}
// 172.23.2.190