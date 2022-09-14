import 'package:center_source_code_test/Models/imageModel.dart';
import 'package:http/http.dart' as http;
class ApiService{


  Future<ImageModel> getData(String searchIteam,String pageNumber)async{
    String apikey ="29897489-eeece90fdef3beaec6d4284f7";
    String urls ="https://pixabay.com/api/?key=$apikey&q=$searchIteam&image_type=photo&page=1&per_page=$pageNumber";

    print("function called");
    var response = await http.get(Uri.parse(urls));

    if(response.statusCode == 200){
      var body = response.body;
      final dataModel = imageModelFromJson(body);
      print(body);
      return dataModel;
    }else{
      throw Exception("faild");
    }
  }

}