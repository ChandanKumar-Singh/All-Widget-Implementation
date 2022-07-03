import 'package:dart_code_viewer2/dart_code_viewer2.dart';
import 'package:demoo/ImagePickAndRefractController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CodePopup extends StatelessWidget {
  CodePopup(
      {Key? key, required this.title, required this.code, required this.widget})
      : super(key: key);
  final String title, code;
  final Widget widget;

  // bool showDartViewer = false;

  ImagePickAndRefractController controller =
      Get.put(ImagePickAndRefractController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return Obx(() {
                return SizedBox(
                    height: Get.height * 0.5,
                    // width: double.minPositive,
                    child: CupertinoActionSheet(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                          CupertinoButton(
                            child: const Icon(
                                CupertinoIcons.doc_on_clipboard_fill),
                            onPressed: () {
                              String cToCopy = code.substring(0, code.length);
                              Clipboard.setData(ClipboardData(text: cToCopy))
                                  .then(
                                (value) {
                                  //only if ->
                                  Get.snackbar('Congratulations 🥂🥂🥂',
                                      'Code copied successfully.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green[400]);
                                },
                              );
                            },
                          ),
                          CupertinoButton(
                            child: const Icon(
                              CupertinoIcons.ant,
                              color: Colors.deepPurple,
                            ),
                            onPressed: () {
                              controller.showDartViewer.value =
                                  !controller.showDartViewer.value;
                            },
                          ),
                        ],
                      ),
                      message: SingleChildScrollView(
                        // scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(0),
                        child: controller.showDartViewer.value
                            ? DartCodeViewer(
                                code,
                                width: Get.width,
                                copyButtonText: null,
                                backgroundColor: Colors.transparent,
                                showCopyButton: false,
                                height: double.maxFinite,
                              )
                            : Text(
                                code,
                                style: const TextStyle(color: Colors.red),
                              ),
                      ),
                      messageScrollController: ScrollController(
                          initialScrollOffset: 10, keepScrollOffset: true),
                    ));
              });
            },
            barrierDismissible: true);
      },
      child: widget,
    );
  }
}
