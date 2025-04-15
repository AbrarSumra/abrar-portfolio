import 'dart:io';
import 'dart:math';

import 'package:abrar_portfolio/app/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/text_constant/text_constant.dart';

class CustomFunctions {
  static final ImagePicker picker = ImagePicker();

  /// First Letter Capital Function
  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// getGreetingMessage
  static String getGreetingMessage() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  /// This Function for GridView
  static double calculateAspectRatioForTwoItems(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = (screenWidth - 30) / 2;
    double itemHeight = itemWidth * 1.3;
    return itemWidth / itemHeight;
  }

  // Function to generate a random light color
  static Color getRandomLightColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(75) + 180, // Red: Random value between 180 and 255
      random.nextInt(75) + 180, // Green: Random value between 180 and 255
      random.nextInt(75) + 180, // Blue: Random value between 180 and 255
      0.7, // Alpha (opacity): 1 for fully opaque
    );
  }

  /// Date Function (ex: 10/12/2000)
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatBackendDate(String backendDate) {
    try {
      // Parse the backend date using the correct format
      DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(backendDate);

      // Format to MM/dd/yyyy
      String formattedDate = DateFormat("dd/MM/yyyy").format(parsedDate);
      return formattedDate;
    } catch (e) {
      print("Error formatting date: $e");
      return "Invalid Date"; // Return a default value in case of an error
    }
  }

  /// Pick Image From Gallery
  static Future<File?> pickAndProcessImage({
    required BuildContext context,
    bool cropImage = true,
    bool compressImage = true,
  }) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;

      File imageFile = File(pickedFile.path);

      // Optionally crop the image
      File? processedFile = imageFile;
      if (cropImage) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: imageFile.path,
          compressFormat: ImageCompressFormat.png,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: AppColor.kAppMainColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: 'Crop Image',
            ),
          ],
        );

        if (croppedFile == null) return null;

        processedFile = File(croppedFile.path);
      }

      // Optionally compress the image
      if (compressImage) {
        processedFile = await CustomFunctions.compressImage(
          XFile(processedFile.path),
        );
      }

      return processedFile;
    } catch (e) {
      debugPrint('Error picking, cropping, or compressing image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: NormalText(title: 'Failed to process image: $e')),
      );
      return null;
    }
  }

  /// For Compress Image
  static Future<File> compressImage(XFile xfile) async {
    final file = File(xfile.path);
    final dir = await getTemporaryDirectory();

    // Set the target extension to always be PNG
    final targetPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.png';

    try {
      // Compress the image initially with 80% quality
      var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 80,
        minWidth: 800,
        minHeight: 800,
        format: CompressFormat.png, // Always save as PNG
      );

      if (result == null) {
        throw Exception('Initial image compression failed');
      }

      int quality = 80;

      // Reduce quality further if the file size exceeds 1 MB
      while (await result!.length() > 1 * 1024 * 1024 && quality > 10) {
        quality -= 10; // Decrease quality by 10%
        result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          targetPath,
          quality: quality,
          minWidth: 800,
          minHeight: 800,
          format: CompressFormat.png, // Ensure format remains PNG
        );
      }

      if (await result.length() > 1 * 1024 * 1024) {
        throw Exception('Unable to compress image to under 1MB');
      }

      return File(result.path);
    } catch (e) {
      debugPrint('Error compressing image: $e');
      rethrow; // Re-throw the exception for higher-level handling
    }
  }
}
