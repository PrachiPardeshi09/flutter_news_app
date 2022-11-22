import 'dart:io';
import 'package:get/get.dart';
import '../data/news_model.dart';
import '../network/service_factory.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class NewsDescriptionController extends GetxController{
  final Rx<Articles?> singleEvent = Rx<Articles?>(null);
 final Rx<bool >isLoading = true.obs;
  final RxList<Articles> articles = <Articles>[].obs;
  final pdf = pw.Document();

  @override
  void onInit() async {
    singleEvent.value = Get.arguments as Articles;
    getData();
  }
  getData() async {
    try {
      isLoading(true);
      var Discription = await RemoteServices.fetchDescription();
      if (Discription != null) {
        singleEvent.value = Discription;
      }
    } finally {
      isLoading(false);
    }
  }

}