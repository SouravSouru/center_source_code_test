import 'package:center_source_code_test/Models/imageModel.dart';
import 'package:center_source_code_test/service/apiService.dart';
import 'package:get/get.dart';


class ImageGetxController extends GetxController{

  RxBool loaded = false.obs;
  var imageModel = ImageModel().obs;


  void Getdata(String searchIteam,String pageNumber) async{
    var response = await ApiService().getData(searchIteam,pageNumber);
    if(response.hits!.isNotEmpty){
      imageModel.value = response;
      loaded.value = true;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   // Getdata("car");
  }
}