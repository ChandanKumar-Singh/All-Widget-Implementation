import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:demoo/ImagePickAndRefractController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_image_provider/local_image_provider.dart';

import 'CodePopup.dart';

class ImagePickAndRefract extends GetView<ImagePickAndRefractController> {
  ImagePickAndRefract({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Image Pick and Refract'),
        trailing: GestureDetector(
          onTap: () => Get.toNamed('/csp'),
          child: const Text('Custom S P'),
        ),
      ),
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Wrap(
                    spacing: 5,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            controller.pickImage(ImageSource.camera);
                          },
                          child: const Text('Camera')),
                      ElevatedButton(
                          onPressed: () {
                            controller.pickImage(ImageSource.gallery);
                          },
                          child: const Text('Gallery')),
                      Semantics(
                        excludeSemantics: true,
                        // onTapHint: 'Get Gallery Images',
                        // enabled: true,
                        child: ElevatedButton(
                            onPressed: () {
                              controller.getGalleryImages();
                            },
                            child: const Text('Get Gallery Images')),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            controller.showCupertinoIndicator();
                          },
                          child: const Text('Cupertino  Activity Indicator')),
                      ElevatedButton(
                          onPressed: () {
                            controller.showCupertinoInAlertDialog(context);
                          },
                          child: const Text('Cupertino  Alert Dialog')),
                      CupertinoButton(
                          onPressed: () {},
                          color: Colors.greenAccent,
                          minSize: 150,
                          alignment: Alignment.center,
                          pressedOpacity: 0.6,
                          child: const Text('Cupertino Button')),
                    ],
                  ),
                  Obx(() {
                    return controller.activityIndicator.value
                        ? const CupertinoActivityIndicator(
                            radius: 50,
                            // animating: false,
                          )
                        : SizedBox.shrink();
                  }),
                  CodePopup(
                    title: 'Image Picker',
                    code: r''' Obx(() {
                    return controller.imageFile.value != ''
                        ? Container(
                            width: 300,
                            height: Get.height * 0.3,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(
                                        File(controller.imageFile.value)),
                                    fit: BoxFit.cover)),
                          )
                        : SizedBox(
                            width: 300,
                            height: Get.height * 0.3,
                            child:
                                const Center(child: Text('No Image Selected')),
                          );
                  })''',
                    widget: Obx(() {
                      return controller.imageFile.value != ''
                          ? Container(
                              width: 300,
                              height: Get.height * 0.3,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(
                                          File(controller.imageFile.value)),
                                      fit: BoxFit.cover)),
                            )
                          : SizedBox(
                              width: 300,
                              height: Get.height * 0.3,
                              child: const Center(
                                  child: Text('No Image Selected')),
                            );
                    }),
                  ),
                  CodePopup(
                    title: 'Image Grid',
                    code: r'''Obx(() {
                    return controller.imagesList.value.isNotEmpty
                        ? SizedBox(
                            width: 300,
                            height: Get.height * 0.2,
                            child: Column(
                              children: [
                                Text(controller.imagesList.value.length
                                    .toString()),
                                Expanded(
                                    child: GridView(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 3,
                                          crossAxisSpacing: 3),
                                  children: controller.imagesList.value
                                      .map((e) => Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: DeviceImage(e),
                                                  fit: BoxFit.cover),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  ((e.fileSize)! / 1024 / 1024)
                                                      .toStringAsFixed(2)
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                ),
                                                Text(
                                                  e.id!,
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                            ),
                                          ))
                                      .toList(),
                                ))
                              ],
                            ))
                        : SizedBox(
                            width: 300,
                            height: Get.height * 0.3,
                            child: Center(
                                child: Text(
                                    '${controller.imagesList.value.length}')),
                          );
                  }),''',
                    widget: Obx(() {
                      return controller.imagesList.value.isNotEmpty
                          ? SizedBox(
                              width: 300,
                              height: Get.height * 0.2,
                              child: Column(
                                children: [
                                  Text(controller.imagesList.value.length
                                      .toString()),
                                  Expanded(
                                      child: GridView(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 3,
                                            crossAxisSpacing: 3),
                                    children: controller.imagesList.value
                                        .map((e) => Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: DeviceImage(e),
                                                    fit: BoxFit.cover),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    ((e.fileSize)! /
                                                            1024 /
                                                            1024)
                                                        .toStringAsFixed(2)
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  Text(
                                                    e.id!,
                                                    style: const TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                              ),
                                            ))
                                        .toList(),
                                  ))
                                ],
                              ))
                          : SizedBox(
                              width: 300,
                              height: Get.height * 0.3,
                              child: Center(
                                  child: Text(
                                      '${controller.imagesList.value.length}')),
                            );
                    }),
                  ),
                  CodePopup(
                    title: 'Cupertino Date time picker',
                    code: r''' CupertinoButton(
                    onPressed: () => showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoDatePicker(
                        initialDateTime: controller.dateTime.value,
                        mode: CupertinoDatePickerMode.dateAndTime,
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime newDate) {
                          controller.dateTime.value = newDate;
                        },
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    child: Text(
                      '${controller.dateTime.value.month}-${controller.dateTime.value.day}-${controller.dateTime.value.year}  ${controller.dateTime.value.hour}-${controller.dateTime.value.minute}',
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  )''',
                    widget: CupertinoButton(
                      onPressed: () => showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoDatePicker(
                          initialDateTime: controller.dateTime.value,
                          mode: CupertinoDatePickerMode.dateAndTime,
                          use24hFormat: true,
                          onDateTimeChanged: (DateTime newDate) {
                            controller.dateTime.value = newDate;
                          },
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      child: Text(
                        '${controller.dateTime.value.month}-${controller.dateTime.value.day}-${controller.dateTime.value.year}  ${controller.dateTime.value.hour}-${controller.dateTime.value.minute}',
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                  CodePopup(
                    title: 'Cupertino Context menu',
                    code: r'''CupertinoContextMenu(
                    actions: <Widget>[
                      CupertinoContextMenuAction(
                        child: const Text('Action one'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoContextMenuAction(
                        child: const Text('Action two'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoContextMenuAction(
                        child: const Text('Action three'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                    previewBuilder: (context, animation, widget) {
                      return widget;
                    },
                    child: const Text('Cupertino Context Menu'),
                  )''',
                    widget: CupertinoContextMenu(
                      actions: <Widget>[
                        CupertinoContextMenuAction(
                          child: const Text('Action one'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoContextMenuAction(
                          child: const Text('Action two'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoContextMenuAction(
                          child: const Text('Action three'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                      previewBuilder: (context, animation, widget) {
                        return widget;
                      },
                      child: const Text('Cupertino Context Menu'),
                    ),
                  ),
                  CodePopup(
                    title: 'Cupertino Picker',
                    code: r'''CupertinoButton(
                    onPressed: () => controller.showCupertinoPickerDialog(
                      context,
                      CupertinoPicker(
                        magnification: 1.5,
                        squeeze: 1,
                        useMagnifier: true,
                        itemExtent: controller.kItemExtent,
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          controller.selectedFruit.value = selectedItem;
                        },
                        children: List<Widget>.generate(
                            controller.fruitNames.length, (int index) {
                          return Center(
                            child: Text(
                              controller.fruitNames[index],
                            ),
                          );
                        }),
                      ),
                    ),
                    child: Text(
                      controller.fruitNames[controller.selectedFruit.value],
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  )''',
                    widget: CupertinoButton(
                      onPressed: () => controller.showCupertinoPickerDialog(
                        context,
                        CupertinoPicker(
                          magnification: 1.5,
                          squeeze: 1,
                          useMagnifier: true,
                          itemExtent: controller.kItemExtent,
                          // This is called when selected item is changed.
                          onSelectedItemChanged: (int selectedItem) {
                            controller.selectedFruit.value = selectedItem;
                          },
                          children: List<Widget>.generate(
                              controller.fruitNames.length, (int index) {
                            return Center(
                              child: Text(
                                controller.fruitNames[index],
                              ),
                            );
                          }),
                        ),
                      ),
                      child: Text(
                        controller.fruitNames[controller.selectedFruit.value],
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                  CupertinoPicker(
                    magnification: 2,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: controller.kItemExtent,
                    // This is called when selected item is changed.
                    onSelectedItemChanged: (int selectedItem) {
                      controller.selectedFruit.value = selectedItem;
                    },
                    children: List<Widget>.generate(
                        controller.fruitNames.length, (int index) {
                      return Center(
                        child: Text(
                          controller.fruitNames[index],
                        ),
                      );
                    }),
                  ),
                  CodePopup(
                    title: 'Cupertino Popup Surface',
                    code: r'''CupertinoButton(
                      onPressed: () => showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoPopupSurface(
                          isSurfacePainted: false,
                          child: Container(
                              height: 200, width: 150, color: Colors.blue[400]),
                        ),
                        barrierDismissible: false,
                      ),
                      child: const Text(
                        'Cupertino Popup Surface',
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    )''',
                    widget: CupertinoButton(
                      onPressed: () => showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoPopupSurface(
                          isSurfacePainted: false,
                          child: Container(
                              height: 200, width: 150, color: Colors.blue[400]),
                        ),
                        barrierDismissible: false,
                      ),
                      child: const Text(
                        'Cupertino Popup Surface',
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                  CodePopup(
                    title: 'Cupertino Scrollbar',
                    code: r''' Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SizedBox(
                      height: 200,
                      child: CupertinoScrollbar(
                        thickness: 20.0,
                        thicknessWhileDragging: 30.0,
                        radius: const Radius.circular(34.0),
                        radiusWhileDragging: Radius.zero,
                        child: ListView.builder(
                          itemBuilder: (context, i) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Item: $i'),
                              const Icon(Icons.done)
                            ],
                          ),
                          itemCount: 21,
                        ),
                      ),
                    ),
                  )''',
                    widget: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: SizedBox(
                        height: 200,
                        child: CupertinoScrollbar(
                          thickness: 20.0,
                          thicknessWhileDragging: 30.0,
                          radius: const Radius.circular(34.0),
                          radiusWhileDragging: Radius.zero,
                          child: ListView.builder(
                            itemBuilder: (context, i) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Item: $i'),
                                const Icon(Icons.done)
                              ],
                            ),
                            itemCount: 21,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const CupertinoSearchTextField(),
                  CodePopup(
                    title: 'Cupertino Segment Control',
                    code: r'''Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoSegmentedControl(
                        groupValue: controller.segmentControl.value,
                        children: const <String, Widget>{
                          '1': Text('1st'),
                          '2': Text('2nd'),
                          '3': Text('3rd'),
                        },
                        onValueChanged: (String string) {
                          controller.segmentControl.value = string;
                        }),
                  ),''',
                    widget: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSegmentedControl(
                          groupValue: controller.segmentControl.value,
                          children: const <String, Widget>{
                            '1': Text('1st'),
                            '2': Text('2nd'),
                            '3': Text('3rd'),
                          },
                          onValueChanged: (String string) {
                            controller.segmentControl.value = string;
                          }),
                    ),
                  ),
                  Row(
                    children: [
                      CupertinoSlider(
                          value: controller.sliderValue.value,
                          onChanged: (val) {
                            controller.sliderValue.value = val;
                          }),
                      Text(
                          '${(controller.sliderValue.value * 100).toStringAsFixed(2)}'),
                    ],
                  ),
                  CodePopup(
                    title: 'Cupertino Sliding Segmented Control',
                    code: r'''CupertinoSlidingSegmentedControl(
                        groupValue: controller.segmentControl.value,
                        children: const <String, Widget>{
                          '1': Padding(
                            child: Text('1st'),
                            padding: EdgeInsets.all(20),
                          ),
                          '2': Text('2nd'),
                          '3': Text('3rd'),
                        },
                        onValueChanged: (String? string) {
                          controller.segmentControl.value = string!;
                        })''',
                    widget: CupertinoSlidingSegmentedControl(
                        groupValue: controller.segmentControl.value,
                        children: const <String, Widget>{
                          '1': Padding(
                            child: Text('1st'),
                            padding: EdgeInsets.all(20),
                          ),
                          '2': Text('2nd'),
                          '3': Text('3rd'),
                        },
                        onValueChanged: (String? string) {
                          controller.segmentControl.value = string!;
                        }),
                  ),
                  CodePopup(
                    title: 'Cupertino Switch',
                    code: r'''MergeSemantics(
                    child: ListTile(
                      leading: const Text('Tap'),
                      title: const Text('Lights'),
                      trailing: CupertinoSwitch(
                        value: controller.lights.value,
                        onChanged: (bool value) {
                          controller.lights.value = value;
                        },
                      ),
                      onTap: () {
                        controller.lights.value = !controller.lights.value;
                      },
                      tileColor: controller.lights.value
                          ? CupertinoColors.inactiveGray
                          : CupertinoColors.systemPurple,
                    ),
                  )''',
                    widget: MergeSemantics(
                      child: ListTile(
                        leading: const Text('Tap'),
                        title: const Text('Lights'),
                        trailing: CupertinoSwitch(
                          value: controller.lights.value,
                          onChanged: (bool value) {
                            controller.lights.value = value;
                          },
                        ),
                        onTap: () {
                          controller.lights.value = !controller.lights.value;
                        },
                        tileColor: controller.lights.value
                            ? CupertinoColors.inactiveGray
                            : CupertinoColors.systemPurple,
                      ),
                    ),
                  ),
                  CodePopup(
                    title: 'Cupertino Tab Bar',
                    code: r''' Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 100,
                      child: CupertinoTabScaffold(
                        tabBar: CupertinoTabBar(
                          items: const <BottomNavigationBarItem>[
                            BottomNavigationBarItem(
                                icon: Icon(CupertinoIcons.add_circled_solid)),
                            BottomNavigationBarItem(
                                icon: Icon(CupertinoIcons.ant)),
                            BottomNavigationBarItem(
                                icon: Icon(CupertinoIcons.arrow_2_circlepath)),
                          ],
                          // onTap: (i) => controller.tabIndex.value = i,
                          // currentIndex: controller.tabIndex.value,
                          backgroundColor: CupertinoColors.systemPink,
                          activeColor: CupertinoColors.systemBackground,
                          inactiveColor: CupertinoColors.black,
                        ),
                        tabBuilder: (BuildContext context, int index) {
                          return CupertinoTabView(
                              builder: (BuildContext context) {
                            return Center(
                              child: Text('Content of tab $index'),
                            );
                          });
                        },
                      ),
                    ),
                  )''',
                    widget: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: 100,
                        child: CupertinoTabScaffold(
                          tabBar: CupertinoTabBar(
                            items: const <BottomNavigationBarItem>[
                              BottomNavigationBarItem(
                                  icon: Icon(CupertinoIcons.add_circled_solid)),
                              BottomNavigationBarItem(
                                  icon: Icon(CupertinoIcons.ant)),
                              BottomNavigationBarItem(
                                  icon:
                                      Icon(CupertinoIcons.arrow_2_circlepath)),
                            ],
                            // onTap: (i) => controller.tabIndex.value = i,
                            // currentIndex: controller.tabIndex.value,
                            backgroundColor: CupertinoColors.systemPink,
                            activeColor: CupertinoColors.systemBackground,
                            inactiveColor: CupertinoColors.black,
                          ),
                          tabBuilder: (BuildContext context, int index) {
                            return CupertinoTabView(
                                builder: (BuildContext context) {
                              return Center(
                                child: Text('Content of tab $index'),
                              );
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      prefix: Icon(CupertinoIcons.circle_bottomthird_split),
                      suffix: Icon(CupertinoIcons.search_circle),
                    ),
                  ),
                  CodePopup(
                    title: 'Cupertino time picker',
                    code: r'''Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                          child: const Text('Time Picker'),
                          onPressed: () =>
                              controller.showCupertinoTimePicker(context)),
                      Text(
                          '${controller.duration.value.inHours}-${controller.duration.value.inMinutes % 60}-${controller.duration.value.inSeconds % 3600 % 60}'),
                    ],
                  )''',
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CupertinoButton(
                            child: const Text('Time Picker'),
                            onPressed: () =>
                                controller.showCupertinoTimePicker(context)),
                        Text(
                            '${controller.duration.value.inHours}-${controller.duration.value.inMinutes % 60}-${controller.duration.value.inSeconds % 3600 % 60}'),
                      ],
                    ),
                  ),
                  CodePopup(
                    title: 'AutoComplete',
                    code: r'''SizedBox(
                    height: 200,
                    child: Scaffold(
                      body: Autocomplete<String>(
                        displayStringForOption: (String option) => option,
                        fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted,
                        ) {
                          return CupertinoTextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                          );
                        },
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          return controller.autoCompleteTextFieldOptions.where((String option) {
                            return option
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          debugPrint('You just selected $selection');
                        },
                      ),
                    ),
                  )''',
                    widget: SizedBox(
                      height: 200,
                      child: Scaffold(
                        body: Autocomplete<String>(
                          displayStringForOption: (String option) => option,
                          fieldViewBuilder: (
                            BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted,
                          ) {
                            return CupertinoTextField(
                              controller: textEditingController,
                              focusNode: focusNode,
                            );
                          },
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return const Iterable<String>.empty();
                            }
                            return controller.autoCompleteTextFieldOptions
                                .where((String option) {
                              return option.contains(
                                  textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (String selection) {
                            debugPrint('You just selected $selection');
                          },
                        ),
                      ),
                    ),
                  ),
                  CodePopup(
                    title: 'Cupertino Form Field Row',
                    code: r'''Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CupertinoTextFormFieldRow(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: CupertinoColors.destructiveRed,
                                style: BorderStyle.solid),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          placeholder: 'Enter your email',
                          validator: (String? value) {
                            Pattern match = RegExp(
                                '^[a-zA-Z0-9(\_)]+[\.]?[a-zA-Z0-9(\_)]+@[a-zA-Z0-9(\_\.)]+[\.]+([a-zA-Z]{2,5})+');
                            // Pattern match = RegExp('^\w+\.*\w+@[a-zA-Z0-9(\_\.)]+[\.]+[a-zA-Z]{2,5}');
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else if (value.contains(match)) {
                              return null;
                            } else {
                              return 'Please enter a valid email!';
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate will return true if the form is valid, or false if
                              // the form is invalid.
                              if (controller.formKey.currentState!.validate()) {
                                // Process data.
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  )''',
                    widget: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CupertinoTextFormFieldRow(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: CupertinoColors.destructiveRed,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            placeholder: 'Enter your email',
                            validator: (String? value) {
                              Pattern match = RegExp(
                                  '^[a-zA-Z0-9(\_)]+[\.]?[a-zA-Z0-9(\_)]+@[a-zA-Z0-9(\_\.)]+[\.]+([a-zA-Z]{2,5})+');
                              // Pattern match = RegExp('^\w+\.*\w+@[a-zA-Z0-9(\_\.)]+[\.]+[a-zA-Z]{2,5}');
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              } else if (value.contains(match)) {
                                return null;
                              } else {
                                return 'Please enter a valid email!';
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  // Process data.
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CodePopup(
                    title: 'Absorber Pointer',
                    code: r'''Stack(
                    children: [
                      SizedBox(
                        width: 200.0,
                        height: 100.0,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: null,
                        ),
                      ),
                      SizedBox(
                        width: 100.0,
                        height: 200.0,
                        child: AbsorbPointer(
                          absorbing: true,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue.shade200,
                            ),
                            onPressed: () {},
                            child: null,
                          ),
                        ),
                      ),
                    ],
                  )''',
                    widget: Stack(
                      children: [
                        SizedBox(
                          width: 200.0,
                          height: 100.0,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: null,
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          height: 200.0,
                          child: AbsorbPointer(
                            absorbing: true,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue.shade200,
                              ),
                              onPressed: () {},
                              child: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CodePopup(
                    title: 'Dismissible',
                    code: r''' SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: controller.items.length,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          background: Container(
                            color: Colors.green,
                          ),
                          secondaryBackground: Container(
                            width: 100,
                            color: Colors.red,
                            child: IconButton(
                              onPressed: () =>
                                  controller.items.value.removeAt(index),
                              icon: const Icon(CupertinoIcons.delete),
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          key: ValueKey<int>(controller.items.value[index]),
                          onDismissed: (DismissDirection direction) {
                            controller.items.value.removeAt(index);
                          },
                          child: ListTile(
                            title: Text(
                              'Item ${controller.items.value[index]}',
                            ),
                          ),
                        );
                      },
                    ),
                  )''',
                    widget: SizedBox(
                      height: 200,
                      child: Obx(() {
                        return ListView.builder(
                          itemCount: controller.items.length,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                              background: Container(
                                color: Colors.green,
                              ),
                              secondaryBackground: Container(
                                width: 100,
                                color: Colors.red,
                                child: IconButton(
                                  onPressed: () =>
                                      controller.items.value.removeAt(index),
                                  icon: const Icon(CupertinoIcons.delete),
                                ),
                              ),
                              direction: DismissDirection.endToStart,
                              key: ValueKey<int>(controller.items.value[index]),
                              onDismissed: (DismissDirection direction) {
                                controller.items.value.removeAt(index);
                              },
                              child: ListTile(
                                title: Text(
                                  'Item ${controller.items.value[index]}',
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                  CodePopup(
                    title: 'Draggable and DragTarget',
                    code: r'''Container(
                    color: Colors.grey,
                    height: 400,
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Draggable<int>(
                          // Data is the value this Draggable stores.
                          data: 10,
                          feedback: Container(
                            color: Colors.deepOrange,
                            height: 100,
                            width: 100,
                            child: const Icon(Icons.directions_run),
                          ),
                          childWhenDragging: Container(
                            height: 100.0,
                            width: 100.0,
                            color: Colors.pinkAccent,
                            child: const Center(
                              child: Text('Child When Dragging'),
                            ),
                          ),
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            color: Colors.lightGreenAccent,
                            child: const Center(
                              child: Text('Draggable'),
                            ),
                          ),
                        ),
                        LongPressDraggable(
                          // Data is the value this Draggable stores.
                          data: 10,
                          feedback: Container(
                            color: Colors.deepOrange,
                            height: 100,
                            width: 100,
                            child: const Icon(Icons.directions_run),
                          ),
                          childWhenDragging: Container(
                            height: 100.0,
                            width: 100.0,
                            color: Colors.pinkAccent,
                            child: const Center(
                              child: Text('Child When Dragging'),
                            ),
                          ),
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            color: Colors.lightGreenAccent,
                            child: const Center(
                              child: Text('LongPressDraggable'),
                            ),
                          ),
                        ),
                        DragTarget<int>(
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          ) {
                            return Container(
                              height: 100.0,
                              width: 100.0,
                              color: Colors.cyan,
                              child: Center(
                                child: Text(
                                    'Value is updated to: ${controller.acceptedData.value}'),
                              ),
                            );
                          },
                          onAccept: (int data) {
                            controller.acceptedData.value += data;
                          },
                        ),
                      ],
                    ),
                  )''',
                    widget: Container(
                      color: Colors.grey,
                      height: 400,
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Draggable<int>(
                            // Data is the value this Draggable stores.
                            data: 10,
                            feedback: Container(
                              color: Colors.deepOrange,
                              height: 100,
                              width: 100,
                              child: const Icon(Icons.directions_run),
                            ),
                            childWhenDragging: Container(
                              height: 100.0,
                              width: 100.0,
                              color: Colors.pinkAccent,
                              child: const Center(
                                child: Text('Child When Dragging'),
                              ),
                            ),
                            child: Container(
                              height: 100.0,
                              width: 100.0,
                              color: Colors.lightGreenAccent,
                              child: const Center(
                                child: Text('Draggable'),
                              ),
                            ),
                          ),
                          LongPressDraggable(
                            // Data is the value this Draggable stores.
                            data: 10,
                            feedback: Container(
                              color: Colors.deepOrange,
                              height: 100,
                              width: 100,
                              child: const Icon(Icons.directions_run),
                            ),
                            childWhenDragging: Container(
                              height: 100.0,
                              width: 100.0,
                              color: Colors.pinkAccent,
                              child: const Center(
                                child: Text('Child When Dragging'),
                              ),
                            ),
                            child: Container(
                              height: 100.0,
                              width: 100.0,
                              color: Colors.lightGreenAccent,
                              child: const Center(
                                child: Text('LongPressDraggable'),
                              ),
                            ),
                          ),
                          DragTarget<int>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return Container(
                                height: 100.0,
                                width: 100.0,
                                color: Colors.cyan,
                                child: Center(
                                  child: Text(
                                      'Value is updated to: ${controller.acceptedData.value}'),
                                ),
                              );
                            },
                            onAccept: (int data) {
                              controller.acceptedData.value += data;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  CodePopup(
                    title: 'Draggable Scrollable Sheet',
                    code: r''' SizedBox(
                    height: 400,
                    child: DraggableScrollableSheet(
                      builder: (context, scrollController) {
                        return Container(
                          color: Colors.blue[100],
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: 25,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(title: Text('Item $index'));
                            },
                          ),
                        );
                      },
                      // maxChildSize: 0.8,
                    ),
                  )''',
                    widget: SizedBox(
                      height: 400,
                      child: DraggableScrollableSheet(
                        builder: (context, scrollController) {
                          return Container(
                            color: Colors.blue[100],
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: 25,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(title: Text('Item $index'));
                              },
                            ),
                          );
                        },
                        // maxChildSize: 0.8,
                      ),
                    ),
                  ),
                  CodePopup(
                    title: 'Interactive Viewer',
                    code: r''' InteractiveViewer(
                    child: Container(
                      height: 200,
                      width: Get.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colors.orange, Colors.red],
                          stops: <double>[0.0, 1.0],
                        ),
                      ),
                    ),
                    transformationController:
                        controller.transformationController,
                    boundaryMargin: const EdgeInsets.all(5.0),
                    onInteractionEnd: (ScaleEndDetails endDetails) {
                      print(endDetails);
                      print(endDetails.velocity);
                      controller.transformationController.value =
                          Matrix4.identity();
                      controller.velocity.value =
                          endDetails.velocity.toString();
                    },
                  ),
                  Text(controller.velocity.value,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  InteractiveViewer(
                    transformationController:
                        controller.transformationController,
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 10,
                    child: Container(
                      height: 200,
                      width: Get.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colors.orange, Colors.red],
                          stops: <double>[0.0, 1.0],
                        ),
                      ),
                    ),
                  ),''',
                    widget: Container(
                      height: 500,
                      child: Column(
                        children: [
                          InteractiveViewer(
                            child: Container(
                              height: 200,
                              width: Get.width,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: <Color>[Colors.orange, Colors.red],
                                  stops: <double>[0.0, 1.0],
                                ),
                              ),
                            ),
                            transformationController:
                                controller.transformationController,
                            boundaryMargin: const EdgeInsets.all(5.0),
                            onInteractionEnd: (ScaleEndDetails endDetails) {
                              print(endDetails);
                              print(endDetails.velocity);
                              controller.transformationController.value =
                                  Matrix4.identity();
                              controller.velocity.value =
                                  endDetails.velocity.toString();
                            },
                          ),
                          Text(controller.velocity.value,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          InteractiveViewer(
                            transformationController:
                                controller.transformationController,
                            boundaryMargin: const EdgeInsets.all(20.0),
                            minScale: 0.1,
                            maxScale: 10,
                            child: Container(
                              height: 200,
                              width: Get.width,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: <Color>[Colors.orange, Colors.red],
                                  stops: <double>[0.0, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Offstage(
                        offstage: controller.offstage.value,
                        child: FlutterLogo(
                          key: controller.key,
                          size: 150.0,
                        ),
                      ),
                      Text(
                          'Flutter logo is offstage: ${controller.offstage.value}'),
                      ElevatedButton(
                        child: const Text('Toggle Offstage Value'),
                        onPressed: () {
                          controller.offstage.value =
                              !controller.offstage.value;
                        },
                      ),
                      if (controller.offstage.value)
                        ElevatedButton(
                            child: const Text('Get Flutter Logo size'),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Flutter Logo size is ${controller.getFlutterLogoSize()}'),
                                ),
                              );
                            }),
                    ],
                  ),
                  Container(
                    color: Colors.black,
                    child: Transform(
                      alignment: Alignment.topRight,
                      transform: Matrix4.skewY(1)..rotateZ(-pi / 12.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: const Color(0xFFE8581C),
                        child: const Text('Apartment for rent!'),
                      ),
                    ),
                  ),
                  CodePopup(
                      title: 'Flow menu',
                      code: r'''class FlowMenu extends StatefulWidget {
  const FlowMenu({Key? key}) : super(key: key);

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController menuAnimation;
  IconData lastTapped = Icons.notifications;
  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.new_releases,
    Icons.notifications,
    Icons.settings,
    Icons.menu,
  ];

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() => lastTapped = icon);
    }
  }

  @override
  void initState() {
    super.initState();
    menuAnimation = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  Widget flowMenuItem(IconData icon) {
    final double buttonDiameter =
        MediaQuery.of(context).size.width / menuItems.length;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RawMaterialButton(
        fillColor: lastTapped == icon ? Colors.amber[700] : Colors.blue,
        splashColor: Colors.amber[100],
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
        onPressed: () {
          _updateMenu(icon);
          menuAnimation.status == AnimationStatus.completed
              ? menuAnimation.reverse()
              : menuAnimation.forward();
        },
        child: Icon(
          icon,
          color: Colors.white,
          size: 45.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(menuAnimation: menuAnimation),
      children:
          menuItems.map<Widget>((IconData icon) => flowMenuItem(icon)).toList(),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({required this.menuAnimation})
      : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dx = context.getChildSize(i)!.width * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          dx * menuAnimation.value,
          0,
          0,
        ),
      );
    }
  }
}''',
                      widget: const SizedBox(child: FlowMenu(), height: 400)),
                  CodePopup(
                    title: 'List Tile Selection',
                    code:
                        r'''class ListTileSelectExample extends StatefulWidget {
  const ListTileSelectExample({Key? key}) : super(key: key);

  @override
  ListTileSelectExampleState createState() => ListTileSelectExampleState();
}

class ListTileSelectExampleState extends State<ListTileSelectExample> {
  bool isSelectionMode = false;
  final int listLength = 30;
  late List<bool> _selected;
  bool _selectAll = false;
  bool _isGridMode = false;

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    _selected = List<bool>.generate(listLength, (_) => false);
  }

  @override
  void dispose() {
    _selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'ListTile selection',
          ),
          leading: isSelectionMode
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      isSelectionMode = false;
                    });
                    initializeSelection();
                  },
                )
              : const SizedBox(),
          actions: <Widget>[
            if (_isGridMode)
              IconButton(
                icon: const Icon(Icons.grid_on),
                onPressed: () {
                  setState(() {
                    _isGridMode = false;
                  });
                },
              )
            else
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  setState(() {
                    _isGridMode = true;
                  });
                },
              ),
            if (isSelectionMode)
              TextButton(
                  child: !_selectAll
                      ? const Text(
                          'select all',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          'unselect all',
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () {
                    _selectAll = !_selectAll;
                    setState(() {
                      _selected =
                          List<bool>.generate(listLength, (_) => _selectAll);
                    });
                  }),
          ],
        ),
        body: _isGridMode
            ? GridBuilder(
                isSelectionMode: isSelectionMode,
                selectedList: _selected,
                onSelectionChange: (bool x) {
                  setState(() {
                    isSelectionMode = x;
                  });
                },
              )
            : ListBuilder(
                isSelectionMode: isSelectionMode,
                selectedList: _selected,
                onSelectionChange: (bool x) {
                  setState(() {
                    isSelectionMode = x;
                  });
                },
              ));
  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    Key? key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  }) : super(key: key);

  final bool isSelectionMode;
  final Function(bool)? onSelectionChange;
  final List<bool> selectedList;

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.selectedList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () => _toggle(index),
            onLongPress: () {
              if (!widget.isSelectionMode) {
                setState(() {
                  widget.selectedList[index] = true;
                });
                widget.onSelectionChange!(true);
              }
            },
            child: GridTile(
                child: Container(
              child: widget.isSelectionMode
                  ? Checkbox(
                      onChanged: (bool? x) => _toggle(index),
                      value: widget.selectedList[index])
                  : const Icon(Icons.image),
            )),
          );
        });
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    Key? key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  }) : super(key: key);

  final bool isSelectionMode;
  final List<bool> selectedList;
  final Function(bool)? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.selectedList.length,
        itemBuilder: (_, int index) {
          return ListTile(
              onTap: () => _toggle(index),
              onLongPress: () {
                if (!widget.isSelectionMode) {
                  setState(() {
                    widget.selectedList[index] = true;
                  });
                  widget.onSelectionChange!(true);
                }
              },
              trailing: widget.isSelectionMode
                  ? Checkbox(
                      value: widget.selectedList[index],
                      onChanged: (bool? x) => _toggle(index),
                    )
                  : const SizedBox.shrink(),
              title: Text('item $index'));
        });
  }
}''',
                    widget: const SizedBox(
                        child: MaterialApp(home: ListTileSelectExample()),
                        height: 500),
                  ),
                  const Divider(thickness: 1.5),
                  SizedBox(
                    height: 150,
                    child: MaterialApp(
                      home: Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 4.0, // gap between lines
                        children: <Widget>[
                          Chip(
                            avatar: CircleAvatar(
                                backgroundColor: Colors.blue.shade900,
                                child: const Text('AH')),
                            label: const Text('Hamilton'),
                            deleteIcon: const Icon(Icons.delete),
                            deleteButtonTooltipMessage: 'Delete',
                          ),
                          Chip(
                            avatar: CircleAvatar(
                                backgroundColor: Colors.blue.shade900,
                                child: const Text('ML')),
                            label: const Text('Lafayette'),
                          ),
                          Chip(
                            avatar: CircleAvatar(
                                backgroundColor: Colors.blue.shade900,
                                child: const Text('HM')),
                            label: const Text('Mulligan'),
                          ),
                          Chip(
                            avatar: CircleAvatar(
                                backgroundColor: Colors.blue.shade900,
                                child: const Text('JL')),
                            label: const Text('Laurens'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(thickness: 1.5),
                  CodePopup(
                    title: 'SliverList',
                    code: r'''SizedBox(
                    height: 300,
                    child: MaterialApp(
                      home: CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.all(20),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate(List.generate(
                                9,
                                (index) => Container(
                                  alignment: Alignment.center,
                                  color: Colors.teal[100 * index],
                                  child: Text('grid item $index'),
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )''',
                    widget: SizedBox(
                      height: 300,
                      child: MaterialApp(
                        home: CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.all(20),
                              sliver: SliverList(
                                delegate: SliverChildListDelegate(List.generate(
                                  9,
                                  (index) => Container(
                                    alignment: Alignment.center,
                                    color: Colors.teal[100 * index],
                                    child: Text('grid item $index'),
                                  ),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 1500,
                    width: Get.width * 0.7,
                    color: Colors.black12,
                    child: MaterialApp(
                      theme: ThemeData(
                          // backgroundColor: Colors.black38,
                          // primaryColor: Colors.black38,
                          scaffoldBackgroundColor: Colors.black12),
                      home: Builder(builder: (context) {
                        return Scaffold(
                          body: SingleChildScrollView(
                            child: Column(
                              children: [
                                CodePopup(
                                  title: 'Dropdwon Button',
                                  code: r'''DropdownButton<String>(
                                  hint: const Text('Tap to select'),
                                  onChanged: (String? value) {
                                    controller.dropdwonValue.value = value!;
                                  },
                                  items: <String>[
                                    'My',
                                    'name',
                                    'is',
                                    'Chandan',
                                    'Kumar',
                                    'Singh'
                                  ]
                                      .map((e) => DropdownMenuItem(
                                            child: Text('$e'),
                                            value: e,
                                          ))
                                      .toList(),
                                  value: controller.dropdwonValue.value,
                                  icon: const Icon(
                                      CupertinoIcons.arrow_turn_right_down),
                                )''',
                                  widget: DropdownButton<String>(
                                    hint: const Text('Tap to select'),
                                    onChanged: (String? value) {
                                      controller.dropdwonValue.value = value!;
                                    },
                                    items: <String>[
                                      'My',
                                      'name',
                                      'is',
                                      'Chandan',
                                      'Kumar',
                                      'Singh'
                                    ]
                                        .map((e) => DropdownMenuItem(
                                              child: Text('$e'),
                                              value: e,
                                            ))
                                        .toList(),
                                    value: controller.dropdwonValue.value,
                                    icon: const Icon(
                                        CupertinoIcons.arrow_turn_right_down),
                                  ),
                                ),
                                CodePopup(
                                    title: 'Popup menu Button',
                                    code: r'''PopupMenuButton(
                                  itemBuilder: (context) {
                                    return <String>[
                                      'My',
                                      'name',
                                      'is',
                                      'Chandan',
                                      'kumar',
                                      'Singh'
                                    ]
                                        .map((e) => PopupMenuItem(
                                              child: Text(e),
                                              value: e,
                                            ))
                                        .toList();
                                  },
                                  initialValue: 'My',
                                  icon: const Icon(
                                      CupertinoIcons.ellipsis_vertical_circle),
                                  onSelected: (String? value) {
                                    controller.popUpValue.value = value!;
                                    // Get.toNamed('/csp');
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: const Text('Welcome'),
                                            content: const Text('Welcome 2'),
                                            actions: [
                                              CupertinoButton(
                                                  child: const Text('Thanks'),
                                                  onPressed: () => Get.back())
                                            ],
                                            scrollController:
                                                ScrollController(),
                                          );
                                        },
                                        routeSettings: const RouteSettings());
                                  },
                                )''',
                                    widget: PopupMenuButton(
                                      itemBuilder: (context) {
                                        return <String>[
                                          'My',
                                          'name',
                                          'is',
                                          'Chandan',
                                          'kumar',
                                          'Singh'
                                        ]
                                            .map((e) => PopupMenuItem(
                                                  child: Text(e),
                                                  value: e,
                                                ))
                                            .toList();
                                      },
                                      initialValue: 'My',
                                      icon: const Icon(CupertinoIcons
                                          .ellipsis_vertical_circle),
                                      onSelected: (String? value) {
                                        controller.popUpValue.value = value!;
                                        // Get.toNamed('/csp');
                                        showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) {
                                              return CupertinoAlertDialog(
                                                title: const Text('Welcome'),
                                                content:
                                                    const Text('Welcome 2'),
                                                actions: [
                                                  CupertinoButton(
                                                      child:
                                                          const Text('Thanks'),
                                                      onPressed: () =>
                                                          Get.back())
                                                ],
                                                scrollController:
                                                    ScrollController(),
                                              );
                                            },
                                            routeSettings:
                                                const RouteSettings());
                                      },
                                    )),
                                Obx(() {
                                  return Text(controller.popUpValue.value);
                                }),
                                CodePopup(
                                    title: 'List tile And Selection',
                                    code: r'''SizedBox(
                                  height: 350,
                                  child: Obx(() {
                                    return Column(
                                      children: [
                                        ListTile(
                                          tileColor: Colors.white,
                                          selectedTileColor: Colors.lime,
                                          selectedColor: Colors.white,
                                          selected: controller
                                              .isAllCheckBoxSelected.value,
                                          leading: Checkbox(
                                              value: controller
                                                  .isAllCheckBoxSelected.value,
                                              onChanged: (bool? value) {
                                                print(value);

                                                controller.isAllCheckBoxSelected
                                                    .value = value!;
                                                controller
                                                    .checkBoxSelectionList.value
                                                    .forEach((element) {
                                                  element.value = value;
                                                });
                                              }),
                                          title: Text(!controller
                                                  .isAllCheckBoxSelected.value
                                              ? 'Select All'
                                              : 'Unselect All'),
                                        ),
                                        Expanded(
                                          child: Card(
                                            //overflow backgroud color resolved
                                            child: ListView.builder(
                                                itemCount: controller
                                                    .checkBoxTileLength.value,
                                                itemBuilder: (context, i) {
                                                  // controller.checkBoxSelectionList.value.length!=13?controller.checkBoxSelectionList.value.addAll([false*13]);
                                                  return Obx(() {
                                                    return ListTile(
                                                      // tileColor: Colors.cyanAccent,
                                                      selectedTileColor:
                                                          Colors.pink,
                                                      selected: controller
                                                          .checkBoxSelectionList
                                                          .value[i]
                                                          .value,
                                                      leading: Checkbox(
                                                        value: controller
                                                            .checkBoxSelectionList
                                                            .value[i]
                                                            .value,
                                                        onChanged:
                                                            (bool? value) {
                                                          print(value);
                                                          controller
                                                              .checkBoxSelectionList
                                                              .value[i]
                                                              .value = value!;
                                                          bool every = controller
                                                              .checkBoxSelectionList
                                                              .value
                                                              .every((element) =>
                                                                  element
                                                                      .value ==
                                                                  true);
                                                          print(
                                                              'every: $every');
                                                          if (every) {
                                                            controller
                                                                .isAllCheckBoxSelected
                                                                .value = true;
                                                          } else {
                                                            controller
                                                                .isAllCheckBoxSelected
                                                                .value = false;
                                                          }
                                                        },
                                                      ),
                                                      title: Text('Item $i'),
                                                    );
                                                  });
                                                }),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                )''',
                                    widget: SizedBox(
                                      height: 350,
                                      child: Obx(() {
                                        return Column(
                                          children: [
                                            ListTile(
                                              tileColor: Colors.white,
                                              selectedTileColor: Colors.lime,
                                              selectedColor: Colors.white,
                                              selected: controller
                                                  .isAllCheckBoxSelected.value,
                                              leading: Checkbox(
                                                  value: controller
                                                      .isAllCheckBoxSelected
                                                      .value,
                                                  onChanged: (bool? value) {
                                                    print(value);

                                                    controller
                                                        .isAllCheckBoxSelected
                                                        .value = value!;
                                                    controller
                                                        .checkBoxSelectionList
                                                        .value
                                                        .forEach((element) {
                                                      element.value = value;
                                                    });
                                                  }),
                                              title: Text(!controller
                                                      .isAllCheckBoxSelected
                                                      .value
                                                  ? 'Select All'
                                                  : 'Unselect All'),
                                            ),
                                            Expanded(
                                              child: Card(
                                                //overflow backgroud color resolved
                                                child: ListView.builder(
                                                    itemCount: controller
                                                        .checkBoxTileLength
                                                        .value,
                                                    itemBuilder: (context, i) {
                                                      // controller.checkBoxSelectionList.value.length!=13?controller.checkBoxSelectionList.value.addAll([false*13]);
                                                      return Obx(() {
                                                        return ListTile(
                                                          // tileColor: Colors.cyanAccent,
                                                          selectedTileColor:
                                                              Colors.pink,
                                                          selected: controller
                                                              .checkBoxSelectionList
                                                              .value[i]
                                                              .value,
                                                          leading: Checkbox(
                                                            value: controller
                                                                .checkBoxSelectionList
                                                                .value[i]
                                                                .value,
                                                            onChanged:
                                                                (bool? value) {
                                                              print(value);
                                                              controller
                                                                  .checkBoxSelectionList
                                                                  .value[i]
                                                                  .value = value!;
                                                              bool every = controller
                                                                  .checkBoxSelectionList
                                                                  .value
                                                                  .every((element) =>
                                                                      element
                                                                          .value ==
                                                                      true);
                                                              print(
                                                                  'every: $every');
                                                              if (every) {
                                                                controller
                                                                    .isAllCheckBoxSelected
                                                                    .value = true;
                                                              } else {
                                                                controller
                                                                    .isAllCheckBoxSelected
                                                                    .value = false;
                                                              }
                                                            },
                                                          ),
                                                          title:
                                                              Text('Item $i'),
                                                        );
                                                      });
                                                    }),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    )),
                                CodePopup(
                                    title:
                                        'Radio group, Switch,Bottom Sheet And Expansion Panel',
                                    code: r''' Wrap(
                                  spacing: Get.width * 0.02,
                                  runSpacing: Get.width * 0.02,
                                  children: List.generate(
                                    Gender.values.length,
                                    (i) => SizedBox(
                                      width: Get.width * 0.3,
                                      child: Row(
                                        children: [
                                          Obx(() {
                                            return Radio<Gender>(
                                              value: Gender.values[i],
                                              groupValue:
                                                  controller.groupValue.value,
                                              onChanged: (Gender? value) {
                                                controller.groupValue.value =
                                                    value!;
                                              },
                                            );
                                          }),
                                          Text(Gender.values[i].name),
                                        ],
                                      ),
                                    ),
                                  )
                                    ..add(Text(
                                        'Selected value: ${controller.groupValue.value.name}'))
                                    ..addAll([
                                      Obx(
                                        () {
                                          return Row(
                                            children: [
                                              Text(
                                                  'Light  ${controller.light.value ? 'on' : 'off'}'),
                                              Switch(
                                                  value: controller.light.value,
                                                  onChanged: (bool? value) =>
                                                      controller.light.value =
                                                          value!),
                                            ],
                                          );
                                        },
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            showBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    height: 300,
                                                    color: Colors.deepPurple,
                                                    child: Center(
                                                      child: Text(
                                                        'WOW',
                                                        style: TextStyle(
                                                            fontSize:
                                                                Get.width * 0.3,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: const Text('Bottom Sheet')),
                                      Obx(() {
                                        return ExpansionPanelList(
                                          expansionCallback: (i, isOpened) {
                                            controller.isOpen.value[i].value =
                                                !isOpened;
                                            print(i);
                                          },
                                          animationDuration:
                                              const Duration(seconds: 1),
                                          expandedHeaderPadding:
                                              const EdgeInsets.all(10),
                                          children: List.generate(
                                            controller.isOpen.value.length,
                                            (index) => ExpansionPanel(
                                              isExpanded: controller
                                                  .isOpen.value[index].value,
                                              body: Text(
                                                  'Expansion Panel body ${index + 1}'),
                                              headerBuilder:
                                                  (BuildContext context,
                                                      bool isExpanded) {
                                                return const Text(
                                                    'Expansion Panel Header');
                                              },
                                            ),
                                          ),
                                        );
                                      }),
                                    ]),
                                )''',
                                    widget: Wrap(
                                      spacing: Get.width * 0.02,
                                      runSpacing: Get.width * 0.02,
                                      children: List.generate(
                                        Gender.values.length,
                                        (i) => SizedBox(
                                          width: Get.width * 0.3,
                                          child: Row(
                                            children: [
                                              Obx(() {
                                                return Radio<Gender>(
                                                  value: Gender.values[i],
                                                  groupValue: controller
                                                      .groupValue.value,
                                                  onChanged: (Gender? value) {
                                                    controller.groupValue
                                                        .value = value!;
                                                  },
                                                );
                                              }),
                                              Text(Gender.values[i].name),
                                            ],
                                          ),
                                        ),
                                      )
                                        ..add(Text(
                                            'Selected value: ${controller.groupValue.value.name}'))
                                        ..addAll([
                                          Obx(
                                            () {
                                              return Row(
                                                children: [
                                                  Text(
                                                      'Light  ${controller.light.value ? 'on' : 'off'}'),
                                                  Switch(
                                                      value: controller
                                                          .light.value,
                                                      onChanged:
                                                          (bool? value) =>
                                                              controller.light
                                                                      .value =
                                                                  value!),
                                                ],
                                              );
                                            },
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                showBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return Container(
                                                        height: 300,
                                                        color:
                                                            Colors.deepPurple,
                                                        child: Center(
                                                          child: Text(
                                                            'WOW',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Get.width *
                                                                        0.3,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child:
                                                  const Text('Bottom Sheet')),
                                          Obx(() {
                                            return ExpansionPanelList(
                                              expansionCallback: (i, isOpened) {
                                                controller.isOpen.value[i]
                                                    .value = !isOpened;
                                                print(i);
                                              },
                                              animationDuration:
                                                  const Duration(seconds: 1),
                                              expandedHeaderPadding:
                                                  const EdgeInsets.all(10),
                                              children: List.generate(
                                                controller.isOpen.value.length,
                                                (index) => ExpansionPanel(
                                                  isExpanded: controller.isOpen
                                                      .value[index].value,
                                                  body: Text(
                                                      'Expansion Panel body ${index + 1}'),
                                                  headerBuilder:
                                                      (BuildContext context,
                                                          bool isExpanded) {
                                                    return const Text(
                                                        'Expansion Panel Header');
                                                  },
                                                ),
                                              ),
                                            );
                                          }),
                                        ]),
                                    )),
                                const Text('\n Data Table'),
                                CodePopup(
                                  title: 'Data Table',
                                  code: r'''SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                      columns: List.generate(
                                        controller.columnData.value.length,
                                        (index) => DataColumn(
                                            label: Text(controller
                                                .columnData.value[index])),
                                      ),
                                      rows: List.generate(
                                        controller.rowDataList.value.length,
                                        (row) => DataRow(
                                            cells: List.generate(
                                                controller.rowDataList
                                                    .value[row].length, (cell) {
                                          // print(controller
                                          //     .rowDataList.value[row]);
                                          return DataCell(
                                            Text(controller
                                                .rowDataList.value[row][cell]
                                                .toString()),
                                          );
                                        })),
                                      )),
                                )''',
                                  widget: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                        columns: List.generate(
                                          controller.columnData.value.length,
                                          (index) => DataColumn(
                                              label: Text(controller
                                                  .columnData.value[index])),
                                        ),
                                        rows: List.generate(
                                          controller.rowDataList.value.length,
                                          (row) => DataRow(
                                              cells: List.generate(
                                                  controller
                                                      .rowDataList
                                                      .value[row]
                                                      .length, (cell) {
                                            // print(controller
                                            //     .rowDataList.value[row]);
                                            return DataCell(
                                              Text(controller
                                                  .rowDataList.value[row][cell]
                                                  .toString()),
                                            );
                                          })),
                                        )),
                                  ),
                                ),
                                Obx(() {
                                  return LinearProgressIndicator(
                                    value: controller.linearProgressValue.value,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.green),
                                  );
                                }),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Tooltip(
                                    message: 'Tooltip',
                                    child: Text('Hover me to show tooltip!'),
                                  ),
                                ),
                                CodePopup(
                                  title: 'Stepper',
                                  code: r'''Container(
                                    height: 400,
                                    color: Colors.red,
                                    // margin: const EdgeInsets.all(10),
                                    child: Obx(() {
                                      return Stepper(
                                        type: StepperType.vertical,
                                        currentStep:
                                            controller.currentStep.value,
                                        onStepCancel: () {
                                          if (controller.currentStep.value >
                                              0) {
                                            controller.currentStep.value -= 1;
                                          }
                                        },
                                        onStepContinue: () {
                                          if (controller.currentStep.value >=
                                                  0 &&
                                              controller.currentStep.value <
                                                  6) {
                                            controller.currentStep.value += 1;
                                            print(controller.currentStep.value);
                                          }
                                        },
                                        onStepTapped: (int index) {
                                          controller.currentStep.value = index;
                                        },
                                        steps: <Step>[
                                          Step(
                                              content: const Text('conent'),
                                              title: const Text('title'),
                                              isActive: controller
                                                      .currentStep.value ==
                                                  0,
                                              state: StepState.editing),
                                          Step(
                                              content: const Text('conent'),
                                              title: const Text('title'),
                                              isActive: controller
                                                      .currentStep.value ==
                                                  1),
                                          Step(
                                              content: const Text('conent'),
                                              title: const Text('title'),
                                              isActive: controller
                                                      .currentStep.value ==
                                                  2),
                                          Step(
                                              content: const Text('conent'),
                                              title: const Text('title'),
                                              isActive: controller
                                                      .currentStep.value ==
                                                  3),
                                          Step(
                                              content: const Text('content'),
                                              title: const Text('title'),
                                              isActive: controller
                                                      .currentStep.value ==
                                                  4),
                                          Step(
                                              content: const Text('content'),
                                              title: const Text('title'),
                                              isActive: controller
                                                      .currentStep.value ==
                                                  5),
                                          Step(
                                              content: const Text('conent'),
                                              title: const Text('title'),
                                              isActive: controller
                                                      .currentStep.value ==
                                                  6),
                                        ],
                                      );
                                    })
                                    )''',
                                  widget: Container(
                                      height: 400,
                                      color: Colors.red,
                                      // margin: const EdgeInsets.all(10),
                                      child: Obx(() {
                                        return Stepper(
                                          type: StepperType.vertical,
                                          currentStep:
                                              controller.currentStep.value,
                                          onStepCancel: () {
                                            if (controller.currentStep.value >
                                                0) {
                                              controller.currentStep.value -= 1;
                                            }
                                          },
                                          onStepContinue: () {
                                            if (controller.currentStep.value >=
                                                    0 &&
                                                controller.currentStep.value <
                                                    6) {
                                              controller.currentStep.value += 1;
                                              print(
                                                  controller.currentStep.value);
                                            }
                                          },
                                          onStepTapped: (int index) {
                                            controller.currentStep.value =
                                                index;
                                          },
                                          steps: <Step>[
                                            Step(
                                                content: const Text('conent'),
                                                title: const Text('title'),
                                                isActive: controller
                                                        .currentStep.value ==
                                                    0,
                                                state: StepState.editing),
                                            Step(
                                                content: const Text('conent'),
                                                title: const Text('title'),
                                                isActive: controller
                                                        .currentStep.value ==
                                                    1),
                                            Step(
                                                content: const Text('conent'),
                                                title: const Text('title'),
                                                isActive: controller
                                                        .currentStep.value ==
                                                    2),
                                            Step(
                                                content: const Text('conent'),
                                                title: const Text('title'),
                                                isActive: controller
                                                        .currentStep.value ==
                                                    3),
                                            Step(
                                                content: const Text('content'),
                                                title: const Text('title'),
                                                isActive: controller
                                                        .currentStep.value ==
                                                    4),
                                            Step(
                                                content: const Text('content'),
                                                title: const Text('title'),
                                                isActive: controller
                                                        .currentStep.value ==
                                                    5),
                                            Step(
                                                content: const Text('conent'),
                                                title: const Text('title'),
                                                isActive: controller
                                                        .currentStep.value ==
                                                    6),
                                          ],
                                        );
                                      })),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  CodePopup(
                    title: 'BackdropFilter',
                    code: r'''SizedBox(
                      height: 300,
                      child: Stack(
                        // fit: StackFit.expand,
                        children: <Widget>[
                          Text('0' * 10000),
                          Center(
                            child: ClipRect(
                              // <-- clips to the 200x200 [Container] below
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10.0,
                                  sigmaY: 10.0,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 200.0,
                                  height: 200.0,
                                  child: const Text('Hello World'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )''',
                    widget: SizedBox(
                      height: 300,
                      child: Stack(
                        // fit: StackFit.expand,
                        children: <Widget>[
                          Text('0' * 10000),
                          Center(
                            child: ClipRect(
                              // <-- clips to the 200x200 [Container] below
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10.0,
                                  sigmaY: 10.0,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 200.0,
                                  height: 200.0,
                                  child: const Text('Hello World'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkFRaG5Ofrvz2oUCiHaYCL47FTZHvP_98XLFkMIIaKlrYJhhDbRsi3oaPp9tR5RpSuJl8&usqp=CAU',
                    // color: Colors.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipPath(
                      clipper: MyClipPath(),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkFRaG5Ofrvz2oUCiHaYCL47FTZHvP_98XLFkMIIaKlrYJhhDbRsi3oaPp9tR5RpSuJl8&usqp=CAU',
                          fit: BoxFit.cover,
                          // color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 0.3,
                        colors: <Color>[
                          Color(0xFFEEEEEE),
                          Color(0xFF111133),
                        ],
                        stops: <double>[0.9, 1.0],
                      ),
                    ),
                    position: DecorationPosition.foreground,
                    child: SizedBox(
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const FractionalTranslation(
                    translation: Offset(0.3, 0.4),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 0.3,
                          colors: <Color>[
                            Color(0xFFEEEEEE),
                            Color(0xFF111133),
                          ],
                          stops: <double>[0.9, 1.0],
                        ),
                      ),
                      position: DecorationPosition.foreground,
                      child: SizedBox(
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Opacity(
                      opacity: 01,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkFRaG5Ofrvz2oUCiHaYCL47FTZHvP_98XLFkMIIaKlrYJhhDbRsi3oaPp9tR5RpSuJl8&usqp=CAU',
                              fit: BoxFit.cover,
                              // color: Colors.red,
                            ),
                          ),
                          Opacity(
                              opacity: 0.4,
                              child: Container(
                                color: Colors.green,
                                height: 200,
                                width: 200,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Opacity(
                      opacity: 01,
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 200,
                              width: 200,
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkFRaG5Ofrvz2oUCiHaYCL47FTZHvP_98XLFkMIIaKlrYJhhDbRsi3oaPp9tR5RpSuJl8&usqp=CAU',
                                fit: BoxFit.cover,
                                // color: Colors.red,
                              ),
                            ),
                            Opacity(
                                opacity: 0.4,
                                child: Container(
                                  color: Colors.green,
                                  height: 200,
                                  width: 200,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Opacity(
                      opacity: 01,
                      child: Transform(
                        transform: Matrix4.rotationX(12)
                          ..rotateX(5)
                          ..rotateZ(5),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 200,
                              width: 200,
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkFRaG5Ofrvz2oUCiHaYCL47FTZHvP_98XLFkMIIaKlrYJhhDbRsi3oaPp9tR5RpSuJl8&usqp=CAU',
                                fit: BoxFit.cover,
                                // color: Colors.red,
                              ),
                            ),
                            Opacity(
                                opacity: 0.4,
                                child: Container(
                                  color: Colors.green,
                                  height: 200,
                                  width: 200,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CodePopup(
                      title: 'Draggable Scrollable Sheet',
                      code: r'''Container(
    decoration: BoxDecoration(
    border: Border.all(width: 3, color: Colors.grey)),
    height: 250,
    child: DraggableScrollableSheet(
    initialChildSize: 0.5,
    minChildSize: 0.3,
    maxChildSize: 1,
    builder: (context, scrollConTroller) => ListView.builder(
    itemBuilder: (context, index) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text('Item $index'),
    ),
    controller: scrollConTroller,
    ),
    ),
    )''',
                      widget: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.grey)),
                        height: 250,
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.7,
                          minChildSize: 0.6,
                          maxChildSize: 1,
                          builder: (context, scrollConTroller) =>
                              ListView.builder(
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Item $index'),
                            ),
                            controller: scrollConTroller,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CodePopup(
                      title: 'Draggable Scrollable Sheet',
                      code:
                          r'''class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Tab 1', 'Tab 2'];
    return DefaultTabController(
      length: tabs.length, // This is the number of tabs.
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                // This widget takes the overlapping behavior of the SliverAppBar,
                // and redirects it to the SliverOverlapInjector below. If it is
                // missing, then it is possible for the nested "inner" scroll view
                // below to end up under the SliverAppBar even when the inner
                // scroll view thinks it has not been scrolled.
                // This is not necessary if the "headerSliverBuilder" only builds
                // widgets that do not overlap the next sliver.
                handle:
                NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                    title:
                    const Text('Books'), // This is the title in the app bar.
                    pinned: true,
                    expandedHeight: 150.0,
                    // The "forceElevated" property causes the SliverAppBar to show
                    // a shadow. The "innerBoxIsScrolled" parameter is true when the
                    // inner scroll view is scrolled beyond its "zero" point, i.e.
                    // when it appears to be scrolled below the SliverAppBar.
                    // Without this, there are cases where the shadow would appear
                    // or not appear inappropriately, because the SliverAppBar is
                    // not actually aware of the precise position of the inner
                    // scroll views.
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      // These are the widgets to put in each tab in the tab bar.
                      tabs: tabs.map((String name) => Tab(text: name)).toList(),
                    ),
                ),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                    // This Builder is needed to provide a BuildContext that is
                    // "inside" the NestedScrollView, so that
                    // sliverOverlapAbsorberHandleFor() can find the
                    // NestedScrollView.
                    builder: (BuildContext context) {
                      return CustomScrollView(
                        // The "controller" and "primary" members should be left
                        // unset, so that the NestedScrollView can control this
                        // inner scroll view.
                        // If the "controller" property is set, then this scroll
                        // view will not be associated with the NestedScrollView.
                        // The PageStorageKey should be unique to this ScrollView;
                        // it allows the list to remember its scroll position when
                        // the tab view is not on the screen.
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            // This is the flip side of the SliverOverlapAbsorber
                            // above.
                            handle:
                            NestedScrollView.sliverOverlapAbsorberHandleFor(
                                context),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            // In this example, the inner scroll view has
                            // fixed-height list items, hence the use of
                            // SliverFixedExtentList. However, one could use any
                            // sliver widget here, e.g. SliverList or SliverGrid.
                            sliver: SliverFixedExtentList(
                              // The items in this example are fixed to 48 pixels
                              // high. This matches the Material Design spec for
                              // ListTile widgets.
                              itemExtent: 48.0,
                              delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  // This builder is called for each child.
                                  // In this example, we just number each list item.
                                  return ListTile(
                                    title: Text('Item $index'),
                                  );
                                },
                                // The childCount of the SliverChildBuilderDelegate
                                // specifies how many children this inner list
                                // has. In this example, each tab has a list of
                                // exactly 30 items, but this is arbitrary.
                                childCount: 30,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}''',
                      widget: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.grey)),
                        height: 350,
                        child: MaterialApp(
                          home: MyStatelessWidget(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels == 50) {
                          print('notification.metrics.pixels:     50');
                        }
                        if (notification.metrics.pixels == 100) {
                          print('notification.metrics.pixels:     50');
                        }

                        return true;
                      },
                      child: Container(
                        height: 300,
                        color: Colors.grey,
                        child: ListView.builder(
                          itemExtent: 32,
                          itemCount: 13,
                          itemBuilder: (context, i) => Text(' item $i'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CodePopup(
                      title: 'Draggable Scrollable Sheet',
                      code: r'''MaterialApp(
                          home: Card(
                            child: RefreshIndicator(
                               strokeWidth : 10,
                              color: Colors.red,
                              edgeOffset: 1,
                              displacement: 120,
                              onRefresh: () {
                                return Future.delayed(const Duration(seconds: 3),
                                    () => print('Refresh Indicator'));
                              },
                              child: ListView.builder(
                                itemCount: 13,
                                itemBuilder: (context, i) => Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ListTile(
                                    title: Text(' $i'),
                                    tileColor: Colors.teal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )''',
                      widget: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.grey)),
                        height: 350,
                        child: MaterialApp(
                          home: Card(
                            child: RefreshIndicator(
                              strokeWidth: 10,
                              color: Colors.red,
                              edgeOffset: 1,
                              displacement: 120,
                              onRefresh: () {
                                return Future.delayed(
                                    const Duration(seconds: 15),
                                    () => print('Refresh Indicator'));
                              },
                              child: ListView.builder(
                                itemCount: 13,
                                itemBuilder: (context, i) => Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ListTile(
                                    title: Text(' $i'),
                                    tileColor: Colors.teal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CodePopup(
                      title: 'Draggable Scrollable Sheet',
                      code: r''' MaterialApp(
                          home: Card(
                            child: RefreshIndicator(
                              strokeWidth: 10,
                              color: Colors.red,
                              edgeOffset: 1,
                              displacement: 120,
                              onRefresh: () {
                                return Future.delayed(
                                        const Duration(seconds: 1),
                                        () => controller.reOrderableList.value =
                                            List.generate(13, (index) => index)
                                                .obs)
                                    .then((value) => print('refreshed'));
                              },
                              child: Scrollbar(
                                controller: controller.reoScrollController,
                                thickness: 13,
                                thumbVisibility: true,
                                trackVisibility: true,
                                radius: Radius.circular(10),
                                interactive: true,
                                child: ReorderableListView(
                                    scrollController:
                                        controller.reoScrollController,
                                    header: Container(
                                        padding: const EdgeInsets.all(25),
                                        color: Colors.amber,
                                        child:
                                            const Text('My ReOrderable  List')),
                                    children: controller.reOrderableList.value
                                        .map((task) => Padding(
                                              key: ValueKey(task),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.greenAccent,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.green)),
                                                  child: ListTile(
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            25),
                                                    leading: const Icon(
                                                        Icons.lock_clock),
                                                    title: Text(
                                                      '$task',
                                                      style: const TextStyle(
                                                          fontSize: 24),
                                                    ),
                                                    trailing: const Icon(Icons
                                                        .drag_handle_outlined),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    // The reorder function
                                    onReorder: (oldIndex, newIndex) {
                                      if (newIndex > oldIndex) {
                                        newIndex -= 1;
                                      }
                                      final element = controller
                                          .reOrderableList.value
                                          .removeAt(oldIndex);
                                      controller.reOrderableList.value
                                          .insert(newIndex, element);
                                    }),
                              ),
                            ),
                          ),
                        )''',
                      widget: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.grey)),
                        height: 350,
                        child: MaterialApp(
                          home: Card(
                            child: RefreshIndicator(
                              strokeWidth: 10,
                              color: Colors.red,
                              edgeOffset: 1,
                              displacement: 120,
                              onRefresh: () {
                                return Future.delayed(
                                        const Duration(seconds: 1),
                                        () => controller.reOrderableList.value =
                                            List.generate(13, (index) => index)
                                                .obs)
                                    .then((value) => print('refreshed'));
                              },
                              child: Scrollbar(
                                controller: controller.reoScrollController,
                                thickness: 13,
                                thumbVisibility: true,
                                trackVisibility: true,
                                radius: Radius.circular(10),
                                interactive: true,
                                child: ReorderableListView(
                                    scrollController:
                                        controller.reoScrollController,
                                    header: Container(
                                        padding: const EdgeInsets.all(25),
                                        color: Colors.amber,
                                        child:
                                            const Text('My ReOrderable  List')),
                                    children: controller.reOrderableList.value
                                        .map((task) => Padding(
                                              key: ValueKey(task),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.greenAccent,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.green)),
                                                  child: ListTile(
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            25),
                                                    leading: const Icon(
                                                        Icons.lock_clock),
                                                    title: Text(
                                                      '$task',
                                                      style: const TextStyle(
                                                          fontSize: 24),
                                                    ),
                                                    trailing: const Icon(Icons
                                                        .drag_handle_outlined),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    // The reorder function
                                    onReorder: (oldIndex, newIndex) {
                                      if (newIndex > oldIndex) {
                                        newIndex -= 1;
                                      }
                                      final element = controller
                                          .reOrderableList.value
                                          .removeAt(oldIndex);
                                      controller.reOrderableList.value
                                          .insert(newIndex, element);
                                    }),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.4),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

///
//Flow
class FlowMenu extends StatefulWidget {
  const FlowMenu({Key? key}) : super(key: key);

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController menuAnimation;
  IconData lastTapped = Icons.notifications;
  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.new_releases,
    Icons.notifications,
    Icons.settings,
    Icons.menu,
  ];

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() => lastTapped = icon);
    }
  }

  @override
  void initState() {
    super.initState();
    menuAnimation = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  Widget flowMenuItem(IconData icon) {
    final double buttonDiameter =
        MediaQuery.of(context).size.width / menuItems.length;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RawMaterialButton(
        fillColor: lastTapped == icon ? Colors.amber[700] : Colors.blue,
        splashColor: Colors.amber[100],
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
        onPressed: () {
          _updateMenu(icon);
          menuAnimation.status == AnimationStatus.completed
              ? menuAnimation.reverse()
              : menuAnimation.forward();
        },
        child: Icon(
          icon,
          color: Colors.white,
          size: 45.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(menuAnimation: menuAnimation),
      children:
          menuItems.map<Widget>((IconData icon) => flowMenuItem(icon)).toList(),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({required this.menuAnimation})
      : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dx = context.getChildSize(i)!.width * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          dx * menuAnimation.value,
          0,
          0,
        ),
      );
    }
  }
}

//Grid and list

class ListTileSelectExample extends StatefulWidget {
  const ListTileSelectExample({Key? key}) : super(key: key);

  @override
  ListTileSelectExampleState createState() => ListTileSelectExampleState();
}

class ListTileSelectExampleState extends State<ListTileSelectExample> {
  bool isSelectionMode = false;
  final int listLength = 30;
  late List<bool> _selected;
  bool _selectAll = false;
  bool _isGridMode = false;

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    _selected = List<bool>.generate(listLength, (_) => false);
  }

  @override
  void dispose() {
    _selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'ListTile selection',
          ),
          leading: isSelectionMode
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      isSelectionMode = false;
                    });
                    initializeSelection();
                  },
                )
              : const SizedBox(),
          actions: <Widget>[
            if (_isGridMode)
              IconButton(
                icon: const Icon(Icons.grid_on),
                onPressed: () {
                  setState(() {
                    _isGridMode = false;
                  });
                },
              )
            else
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  setState(() {
                    _isGridMode = true;
                  });
                },
              ),
            if (isSelectionMode)
              TextButton(
                  child: !_selectAll
                      ? const Text(
                          'select all',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          'unselect all',
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () {
                    _selectAll = !_selectAll;
                    setState(() {
                      _selected =
                          List<bool>.generate(listLength, (_) => _selectAll);
                    });
                  }),
          ],
        ),
        body: _isGridMode
            ? GridBuilder(
                isSelectionMode: isSelectionMode,
                selectedList: _selected,
                onSelectionChange: (bool x) {
                  setState(() {
                    isSelectionMode = x;
                  });
                },
              )
            : ListBuilder(
                isSelectionMode: isSelectionMode,
                selectedList: _selected,
                onSelectionChange: (bool x) {
                  setState(() {
                    isSelectionMode = x;
                  });
                },
              ));
  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    Key? key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  }) : super(key: key);

  final bool isSelectionMode;
  final Function(bool)? onSelectionChange;
  final List<bool> selectedList;

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.selectedList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () => _toggle(index),
            onLongPress: () {
              if (!widget.isSelectionMode) {
                setState(() {
                  widget.selectedList[index] = true;
                });
                widget.onSelectionChange!(true);
              }
            },
            child: GridTile(
                child: Container(
              child: widget.isSelectionMode
                  ? Checkbox(
                      onChanged: (bool? x) => _toggle(index),
                      value: widget.selectedList[index])
                  : const Icon(Icons.image),
            )),
          );
        });
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    Key? key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  }) : super(key: key);

  final bool isSelectionMode;
  final List<bool> selectedList;
  final Function(bool)? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.selectedList.length,
        itemBuilder: (_, int index) {
          return ListTile(
              onTap: () => _toggle(index),
              onLongPress: () {
                if (!widget.isSelectionMode) {
                  setState(() {
                    widget.selectedList[index] = true;
                  });
                  widget.onSelectionChange!(true);
                }
              },
              trailing: widget.isSelectionMode
                  ? Checkbox(
                      value: widget.selectedList[index],
                      onChanged: (bool? x) => _toggle(index),
                    )
                  : const SizedBox.shrink(),
              title: Text('item $index'));
        });
  }
}

//Stepper
class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Flutter Stepper Demo'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              type: stepperType,
              physics: const ScrollPhysics(),
              currentStep: _currentStep,
              onStepTapped: (step) => tapped(step),
              onStepContinue: continued,
              onStepCancel: cancel,
              steps: <Step>[
                Step(
                  title: new Text('Account'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Email Address'),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: new Text('Address'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Home Address'),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Postcode'),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: new Text('Mobile Number'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Mobile Number'),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.list),
        onPressed: switchStepsType,
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}

//ClipOval
class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // TODO: implement getClip
    return const Rect.fromLTWH(0, 0, 200, 100);
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}

class MyClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    //quadraticBezierTo
    var controlPoint = Offset(size.width / 2, size.height / 2);
    var endPoint = Offset(size.width, size.height);

    //cubic
    var controlPoint1 = Offset(50, size.height - 100);
    var controlPoint2 = Offset(size.width - 50, size.height);
    var cubicEndPoint = Offset(size.width, size.height - 50);

//arcToPoint
    double radius = 20;

    Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height) // Add line p1p2
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, cubicEndPoint.dx, cubicEndPoint.dy)
      ..lineTo(size.width, size.height) // Add line p2p3
      ..arcToPoint(Offset(size.width, radius))
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius))
      ..lineTo(radius, size.height)
      ..arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius), clockwise: false)
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: const Radius.elliptical(40, 20))
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}

//Nested ScrollView
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Tab 1', 'Tab 2'];
    return DefaultTabController(
      length: tabs.length, // This is the number of tabs.
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                // This widget takes the overlapping behavior of the SliverAppBar,
                // and redirects it to the SliverOverlapInjector below. If it is
                // missing, then it is possible for the nested "inner" scroll view
                // below to end up under the SliverAppBar even when the inner
                // scroll view thinks it has not been scrolled.
                // This is not necessary if the "headerSliverBuilder" only builds
                // widgets that do not overlap the next sliver.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title:
                      const Text('Books'), // This is the title in the app bar.
                  pinned: true,
                  expandedHeight: 150.0,
                  // The "forceElevated" property causes the SliverAppBar to show
                  // a shadow. The "innerBoxIsScrolled" parameter is true when the
                  // inner scroll view is scrolled beyond its "zero" point, i.e.
                  // when it appears to be scrolled below the SliverAppBar.
                  // Without this, there are cases where the shadow would appear
                  // or not appear inappropriately, because the SliverAppBar is
                  // not actually aware of the precise position of the inner
                  // scroll views.
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    // These are the widgets to put in each tab in the tab bar.
                    tabs: tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  // This Builder is needed to provide a BuildContext that is
                  // "inside" the NestedScrollView, so that
                  // sliverOverlapAbsorberHandleFor() can find the
                  // NestedScrollView.
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      // The "controller" and "primary" members should be left
                      // unset, so that the NestedScrollView can control this
                      // inner scroll view.
                      // If the "controller" property is set, then this scroll
                      // view will not be associated with the NestedScrollView.
                      // The PageStorageKey should be unique to this ScrollView;
                      // it allows the list to remember its scroll position when
                      // the tab view is not on the screen.
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          // This is the flip side of the SliverOverlapAbsorber
                          // above.
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          // In this example, the inner scroll view has
                          // fixed-height list items, hence the use of
                          // SliverFixedExtentList. However, one could use any
                          // sliver widget here, e.g. SliverList or SliverGrid.
                          sliver: SliverFixedExtentList(
                            // The items in this example are fixed to 48 pixels
                            // high. This matches the Material Design spec for
                            // ListTile widgets.
                            itemExtent: 48.0,
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                // This builder is called for each child.
                                // In this example, we just number each list item.
                                return ListTile(
                                  title: Text('Item $index'),
                                );
                              },
                              // The childCount of the SliverChildBuilderDelegate
                              // specifies how many children this inner list
                              // has. In this example, each tab has a list of
                              // exactly 30 items, but this is arbitrary.
                              childCount: 30,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
