
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/util/constant.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/test_field_title.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/parcel_category_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ParcelDetailInputView extends StatefulWidget {
  const ParcelDetailInputView({Key? key}) : super(key: key);

  @override
  State<ParcelDetailInputView> createState() => _ParcelDetailInputViewState();
}

class _ParcelDetailInputViewState extends State<ParcelDetailInputView>
    with SingleTickerProviderStateMixin {
  final ImagePicker _imagePicker = ImagePicker();
  List<PickedFile?> _pickedImages = List.generate(3, (_) => null);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Define the options for the dropdown
  List<String> packageSizes = ['Small', 'Medium', 'Large'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: GetBuilder<ParcelController>(builder: (parcelController) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const ParcelCategoryView(),

              TextFieldTitle(title: 'category'.tr, textOpacity: 0.8),
              CustomTextField(
                prefixIcon: Images.editProfilePhone,
                borderRadius: 10,
                showBorder: false,
                hintText: 'category'.tr,
                isEnabled: false,
                fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
                controller: parcelController.parcelTypeController,
                prefix: false,
              ),

              TextFieldTitle(title: 'Size Of Package'.tr, textOpacity: 0.8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColor.withOpacity(0.04),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text('Select Package Size'), // Add hint text here
                    items: packageSizes.map((size) {
                      return DropdownMenuItem(
                        value: size,
                        child: Text(size),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        parcelController.selectedPackageSize.value =
                            value.toString();
                      });
                    },
                    value: parcelController.selectedPackageSize.value.isNotEmpty
                        ? parcelController.selectedPackageSize.value
                        : null,
                  ),
                ),
              ),

              TextFieldTitle(title: 'parcel_weight'.tr, textOpacity: 0.8),
              CustomTextField(
                prefixIcon: Images.editProfilePhone,
                borderRadius: 10,
                showBorder: false,
                hintText: 'Parcel Weight'.tr,
                fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
                controller: parcelController.parcelWeightController,
                focusNode: parcelController.parcelWeightNode,
                nextFocus: parcelController.parcelitemsNode,
                inputType: TextInputType.text,
                inputAction: TextInputAction.done,
                prefix: false,
              ),
              const SizedBox(height: 10),

              // Display the image text
              Text(
                'Add Image',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              // Add three small cards below the image text
              Row(
                children: [
                  _buildSmallCard(0),
                  SizedBox(width: 52),
                  _buildSmallCard(1),
                  SizedBox(width: 52),
                  _buildSmallCard(2),
                ],
              ),

              const SizedBox(height: Dimensions.paddingSizeDefault),
              CustomButton(
                buttonText: "save_details".tr,
                onPressed: () {
                  int selectedImages =
                      _pickedImages.where((image) => image != null).length;
                  if (selectedImages >= 2) {
                    parcelController.updateParcelState(
                        ParcelDeliveryState.parcelInfoDetails);
                    parcelController.updateParcelDetailsStatus();

                    // Call the function to save details to the database
                    saveDetailsToDatabase(
                      _pickedImages,
                      parcelController.parcelTypeController.text,
                      parcelController.selectedPackageSize.value,
                      parcelController.parcelWeightController.text,
                    );
                  } else {
                    // Show an error message if at least 2 images are not selected
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please upload at least 2 images.'),
                    ));
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSmallCard(int index) {
    String cardLabel = 'Image${index + 1}';

    return GestureDetector(
      onTap: () {
        _showImageSourceDialog(index);
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _pickedImages[index] != null
              ? null
              : Color.fromARGB(255, 213, 210, 210),
          image: _pickedImages[index] != null
              ? DecorationImage(
                  image: FileImage(File(_pickedImages[index]!.path)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            if (_pickedImages[index] == null)
              Center(child: Icon(Icons.add, size: 40, color: Colors.grey)),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                cardLabel,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(index, ImageSource.camera);
              },
              child: Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(index, ImageSource.gallery);
              },
              child: Text("Gallery"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(int index, ImageSource source) async {
    final pickedImage = await _imagePicker.getImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _pickedImages[index] = pickedImage;
      });
    }
  }

  Future<void> saveDetailsToDatabase(List<PickedFile?> pickedImages,
      String category, String packageSize, String parcelWeight) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Constant().url}addpackage/$userId'));

    request.fields.addAll({
      'product_description': category,
      'size_of_package': packageSize,
      'product_weight': parcelWeight,
    });

    for (int i = 0; i < pickedImages.length; i++) {
      if (pickedImages[i] != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'image${i + 1}', pickedImages[i]!.path));
      }
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      // Handle success, e.g., show a success message or navigate to another screen
    } else {
      print(response.reasonPhrase);
      // Handle error, e.g., show an error message to the user
    }
  }
}
