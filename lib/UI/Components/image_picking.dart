// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImagePicking {
//   static const String base64Extension = "data:image/png;base64,";
//
//   Future<File> pick({
//     required BuildContext context,
//   }) async {
//     File pickedImage = File('');
//     await showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         content: Text("اختيار صوره من"),
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TextButton(
//                 onPressed: () async {
//                   pickedImage = await pickImage(
//                     imageSource: ImageSource.camera,
//                   );
//                   Navigator.pop(_);
//                 },
//                 child: Text("كاميرا"),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   pickedImage = await pickImage(
//                     imageSource: ImageSource.gallery,
//                   );
//                   Navigator.pop(_);
//                 },
//                 child: Text("المعرض"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//     return pickedImage;
//   }
//
//   Future<File> pickImage({
//      ImageSource imageSource = ImageSource.gallery,
//   }) async {
//     File pickedFile;
//     try {
//       pickedFile = File(
//           (await ImagePicker().pickImage(source: imageSource, imageQuality: 50))
//               ?.path);
//     } catch (_) {}
//     return pickedFile;
//   }
// }
