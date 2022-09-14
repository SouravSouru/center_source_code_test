import 'package:center_source_code_test/Controllers/ImageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchTextEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  int currentmax = 18;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getMoreImages();
      }
    });
  }

  getMoreImages() async {
    await new Future.delayed(const Duration(seconds: 1));
    if (currentmax < currentmax + 18) {
      print("current max  $currentmax");

      c.Getdata(searchTextEditingController.text, currentmax.toString());
      currentmax = currentmax + 10;
    }
  }

  // getx
  var c = Get.put(ImageGetxController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Centre Source"),
        ),
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: height,
        width: width,
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Container(
                      height: 50,
                      width: width - 130,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        controller: searchTextEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Images',
                            contentPadding: EdgeInsets.only(left: 5)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () async {
                          c.Getdata(searchTextEditingController.text, "18");
                        },
                        child: Container(
                          height: 50,
                          // width: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              "Search",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Obx(() => c.loaded.value == true
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: GridView.builder(
                            controller: _scrollController,
                            itemCount: c.imageModel.value.hits!.length + 1,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (BuildContext context, int index) {
                              print("index count  $index");
                              if (index != 198 &&
                                  index == c.imageModel.value.hits!.length) {
                                return Center(
                                    child: Container(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator()));
                              }
                              if (index == 198) {
                                return Center(child: Text("fully loaded"));
                              }
                              return new Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(FullScreen(
                                        imageUrls: c.imageModel.value
                                            .hits![index].previewUrl
                                            .toString(),
                                      ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(c.imageModel
                                                  .value.hits![index].previewUrl
                                                  .toString()),
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(
                          child: Center(
                            child: Text("No Image"),
                          ),
                        )))
            ],
          ),
        ),
      ),
    );
  }
}

class FullScreen extends StatelessWidget {
  String imageUrls;
  FullScreen({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image(
          image: NetworkImage(imageUrls),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
