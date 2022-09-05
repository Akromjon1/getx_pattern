import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_set_state/controllers/detail_controller.dart';
import '../models/post_model.dart';

enum DetailState { create, update }

class DetailPage extends StatefulWidget {
  final Post? post;
  final DetailState state;

  const DetailPage({Key? key, this.post, this.state = DetailState.create})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final detailController = Get.put(DetailController());

  void init() {
    if (widget.state == DetailState.update) {
      detailController.titleController.value = TextEditingController(text: widget.post!.title);
      detailController.bodyController.value = TextEditingController(text: widget.post!.body);
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Scaffold(
      appBar: AppBar(
      centerTitle: false,
      title: widget.state == DetailState.create
          ? const Text("Add post")
          : const Text("Update post"),
    ),
    body: Stack(
    children: [
    Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
    children: [
    TextField(
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    controller: detailController.titleController.value,
    decoration: InputDecoration(
    label: const Text("Title"),
    hintText: "Title",
    hintStyle: TextStyle(
    color: Colors.grey.shade400,
    ),
    border: const OutlineInputBorder()),
    ),
    const SizedBox(
    height: 15,
    ),
    TextField(
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.done,
    controller: detailController.bodyController.value,
    decoration: InputDecoration(
    label: const Text("Body"),
    hintText: "Body",
    hintStyle: TextStyle(color: Colors.grey.shade400),
    border: const OutlineInputBorder()),
    ),
    const SizedBox(height: 20,),
    MaterialButton(
    color: Colors.blue,
    onPressed: () {
    if (widget.state == DetailState.create) {
    detailController.addPage(context);
    } else {
    detailController.updatePost(context);
    }
    },
    child: const Text("Submit Text"),
    )
    ],
    ),
    ),
    Visibility(
    visible: detailController.isLoading.value,
    child: const CircularProgressIndicator(
    color: Colors.red,
    ),
    )
    ],
    ),
    ),
    );
  }
}
