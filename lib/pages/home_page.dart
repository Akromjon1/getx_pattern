import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.apiPostList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pattern GetX"),
      ),
      body: Obx((){
        return Stack(
          children: [
            ListView.builder(
                itemCount: homeController.items.length,
                itemBuilder: (context, index) {
                  return itemsOfPost(homeController.items[index]);
                }),
            Visibility(
              visible: homeController.isLoading.value,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            )
          ],
        );

      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          homeController.goToDetailPage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemsOfPost(Post post) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        extentRatio: 0.5,
        dismissible: DismissiblePane(onDismissed: () {
          homeController.apiPostDelete(context, post);
        }),
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              homeController.apiPostDelete(context, post);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
          ),
          SlidableAction(
            onPressed: (context) {
              homeController.goToDetailPageUpdate(post, context);
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.update,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Text(
              post.title.toUpperCase(),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              post.body,
              style: const TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
