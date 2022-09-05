import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../services/http_service.dart';



 class DetailController extends GetxController {
   var titleController = TextEditingController().obs;
   var bodyController = TextEditingController().obs;
   RxBool isLoading = false.obs;



  void updatePost(context) async {
    String title = titleController.value.text.trim();
    String body = bodyController.value.text.trim();
    Post post = Post(
        id: Random().nextInt(100),
        title: title,
        body: body,
        userId: Random().nextInt(100));
    isLoading.value = true;
    Network.PUT(Network.API_UPDATE, post.toJson()).then((value) {
      Navigator.pop(context, "refresh");
    });
    isLoading.value = false;
  }

  void addPage(context) async {
    String title = titleController.value.text.trim();
    String body = bodyController.value.text.trim();
    Post post = Post(
        id: Random().nextInt(100),
        title: title,
        body: body,
        userId: Random().nextInt(100));
    isLoading.value = true;
    Network.POST(Network.API_UPDATE, post.toJson()).then((value) {
      Navigator.pop(context, "add");
    });
    isLoading.value = false;
  }

}





