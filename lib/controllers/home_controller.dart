import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import '../models/post_model.dart';
import '../pages/detail_page.dart';
import '../services/http_service.dart';





 class HomeController extends GetxController {
   var items = [].obs;
   RxBool isLoading = false.obs;

  void apiPostList(BuildContext context) async {
    isLoading.value = true;
    String? response =
    await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items.value = Network.parsePostList(response);
    } else {
      items.value = [];
    }
    isLoading.value = false;
  }

  void apiPostDelete(BuildContext context, Post post) async {
    isLoading.value = true;
    String? response = await Network.DEL(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    if (response != null) {
      apiPostList(context);
    }
    // apiPostList();
    isLoading.value = false;
  }

  void goToDetailPage(context) async {
    String? response =
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const DetailPage(
        state: DetailState.create,
      );
    }));
    if (response == "add") {
      apiPostList(context);
    }
  }

  void goToDetailPageUpdate(Post post, context) async {
    String? response =
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailPage(
        post: post,
        state: DetailState.update,
      );
    }));
    if (response == "refresh") {
      apiPostList(context);
    }
  }

}