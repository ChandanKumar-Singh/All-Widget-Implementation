import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_image_provider/local_image_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:local_image_provider/local_image_provider.dart';

enum Gender { male, female, LGBT }

class ImagePickAndRefractController extends GetxController {
  RxString imageFile = ''.obs;
  RxList<LocalImage> imagesList = <LocalImage>[].obs;
  RxBool activityIndicator = false.obs;

  var date = DateTime(2016, 10, 26).obs;
  var time = DateTime(2016, 5, 10, 22, 35).obs;
  var dateTime = DateTime.now().obs;
  var duration = Duration().obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var acceptedData = 0.obs;
  TransformationController transformationController =
      TransformationController();
  RxString velocity = "VELOCITY".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    linearProgressValueTime();
  }

  //Reorderable list
  ScrollController reoScrollController = ScrollController();
  RxInt reOrderIndex = 0.obs;
  RxList reOrderableList = List.generate(13, (index) => index).obs;
  // void reorderData(int oldindex, int newindex){
  //
  //     if(newindex>oldindex){
  //       newindex-=1;
  //     }
  //     final items =widget.item.removeAt(oldindex);
  //   return item.insert(newindex, items);
  //
  // }

  //Clip Oval

  //Dartviewer toggle button
  RxBool showDartViewer = false.obs;

  //Stepper
  RxInt currentStep = 0.obs;

  //Linear progress indicator
  RxDouble linearProgressValue = 0.0.obs;
  void linearProgressValueTime() async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      linearProgressValue.value += 1 / 10;
      if (linearProgressValue.value >= 1.0) {
        linearProgressValue.value = 0.0;
      }
      // print(linearProgressValue.value);
    });
  }

  //Data Table
  //DataColumn
  RxList<String> columnData = ['Name', 'age', 'dob', 'Year'].obs;
  //DataRow
  RxList<List<dynamic>> rowDataList = <List>[
    ['Chandan', '21', '03 Aug', '2001'],
    ['Pratush Anand', '22', '01 Jan', 2000],
    ['Abhishek', '22', '01 Feb', 2000],
  ].obs;

  //ExpansionPanel list
  RxList<RxBool> isOpen = RxList.generate(5, (index) => false.obs);
  //switch
  RxBool light = false.obs;

  //Radio
  Rx<Gender> groupValue = Gender.female.obs;

  //material date time
  var materialDateTime = DateTime(2019, 11, 6).obs;
  Future<void> pickDate(BuildContext context) async {
    DateTime? dt = await showDatePicker(
      currentDate: materialDateTime.value,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2200),
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    materialDateTime.value = dt!;
  }

  //checked box
  RxInt checkBoxTileLength = 13.obs;
  RxList<RxBool> checkBoxSelectionList =
      // <RxBool>[false.obs,false,false,false,false,false,false,false,false,false,false,false,false].obs;
      RxList.generate(13, (index) => false.obs);
  RxBool isAllCheckBoxSelected = false.obs;

  //PopUp
  RxString popUpValue = 'name'.obs;

  //Dropdownmenu
  RxString dropdwonValue = 'Chandan'.obs;

  //Offstage
  final GlobalKey key = GlobalKey();
  RxBool offstage = true.obs;
  Size getFlutterLogoSize() {
    final RenderBox renderLogo =
        key.currentContext!.findRenderObject()! as RenderBox;
    return renderLogo.size;
  }

  //Dismissible
  RxList<int> items = List<int>.generate(13, (int index) => index).obs;

  //Autocomplete
  List<String> autoCompleteTextFieldOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

//time picker
  void showCupertinoTimePicker(BuildContext context) {
    showCupertinoModalPopup(
        barrierColor: Colors.grey,
        context: context,
        builder: (context) {
          return CupertinoTimerPicker(
            onTimerDurationChanged: (time) {
              duration.value = time;
            },
            mode: CupertinoTimerPickerMode.hms,
          );
        });
  }

  //Cupertino Tab
  RxInt tabIndex = 0.obs;

  //Cupertino Switch
  RxBool lights = false.obs;
  //Slider Value
  RxDouble sliderValue = 0.0.obs;

  // Cupertino Segmented Control
  var segmentControl = '1'.obs;

  void showCupertinoIndicator() {
    activityIndicator.value = !activityIndicator.value;
    print(activityIndicator.value);
  }

// Cupertino Picker
  void showCupertinoPickerDialog(
    BuildContext context,
    Widget child,
  ) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

//cupertino picker
  double kItemExtent = 25.0;
  RxInt selectedFruit = 0.obs;
  List<String> fruitNames = <String>[
    'Apple',
    'Mango',
    'Banana',
    'Orange',
    'Pineapple',
    'Strawberry',
  ];

  //showCupertinoInAlertDialog
  Future showCupertinoInAlertDialog(BuildContext context) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Alert'),
            content: Column(
              children: const [
                Text('Proceed with destructive action?'),
                SizedBox(
                  height: 300,
                ),
              ],
            ),
            scrollController: ScrollController(
                initialScrollOffset: 10, keepScrollOffset: true),
            actionScrollController: ScrollController(
                initialScrollOffset: 10, keepScrollOffset: true),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Yes'),
              )
            ],
          );
        });
  }

  void pickImage(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      imageFile.value = file.path;
    } else {
      Get.snackbar('Image Error', 'Could not picked an image');
    }
  }

  void getGalleryImages() async {
    LocalImageProvider imageProvider = LocalImageProvider();
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage].request();
    if (kDebugMode) {
      print(statuses);
    }
    bool hasPermission = await imageProvider.initialize();
    if (kDebugMode) {
      print(hasPermission);
    }
    if (hasPermission) {
      List<LocalImage> images =
          await imageProvider.findImagesInAlbum('-1758176774', 13);
      if (images.isNotEmpty) {
        images.forEach((element) {
          imagesList.add(element);
        });
      } else {
        Get.snackbar('Images Error', 'Images not Found',
            backgroundColor: Colors.red);
      }
    } else {
      await imageProvider.initialize();
      Get.snackbar('Images Error',
          'The user has denied access to images on their device.',
          backgroundColor: Colors.yellow);
    }
  }
}
