// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
// import 'dart:convert';
// import 'dart:async';
// import 'package:async/async.dart';
// import 'package:zenify_app/login/Login.dart';

// import '../../services/constent.dart';

// class FilePickerUploader extends ChangeNotifier {
//   File? _imagefile;

//   File? get imagefile => _imagefile;

//   void setImageFile(File? file) {
//     _imagefile = file;
//     print("aaa");
//     notifyListeners();
//   }
//   // static File? imagefile;

//   Future<String?> pickAndUploadFile({
//     required String dynamicPath,
//     required String id,
//     required String object,
//     required String field,
//   }) async {
//     FilePickerResult? result = await FilePicker.platform
//         .pickFiles(allowMultiple: false, type: FileType.image);

//     if (result != null) {
//       for (PlatformFile file in result.files) {
//         print('File picked: ${file.name}');
//         String filePath = file.path!;
//         File image = File(filePath);
//         setImageFile(image);
//         notifyListeners();
//         // imagefile = image;
//         String? uploadedFileName = await uploadFile(
//           file: image,
//           dynamicPath: dynamicPath,
//           object: object,
//           id: id,
//           field: field,
//         );
//         print('File uploaded successfully!');

//         if (uploadedFileName != null) {
//           return uploadedFileName;
//         }
//       }
//     } else {
//       // User canceled the picker
//       print('User canceled the picker');
//     }

//     return null; // Return null if no file was uploaded
//   }

//   Future<String?> uploadFile({
//     required File file,
//     required String dynamicPath,
//     required String object,
//     required String id,
//     required String field,
//   }) async {
//     // Get the access token and baseUrl
//     String? token = await storage.read(key: "access_token");

//     try {
//       // Create the multipart request
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('${baseUrls}/api/filer/upload'),
//       );

//       // Set the authorization header
//       request.headers.addAll({'Authorization': 'Bearer $token'});

//       // Add the dynamic 'path' parameter to the request body
//       request.fields['path'] = dynamicPath;

//       // Add the file to the request
//       var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
//       var length = await file.length();
//       var multipartFile = http.MultipartFile('files', stream, length,
//           filename: path.basename(file.path));
//       request.files.add(multipartFile);

//       // Send the request
//       var uploadResponse = await request.send();
//       if (uploadResponse.statusCode == 201) {
//         var responseBody = await uploadResponse.stream.bytesToString();
//         var jsonResponse = jsonDecode(responseBody);

//         var message = jsonResponse['message'];
//         var fileNames = jsonResponse['fileNames'];
//         if (fileNames != null && fileNames.isNotEmpty) {
//           var fileName = fileNames[0]; // Assuming the first file name
//           print('File uploaded successfully! File Name: $fileName');
//           print(object);
//           print('$id api/users');
//           print(baseUrls);
//           // Now you can proceed with the PATCH request to update the image field
//           await updateImageField(fileName, object, id, field);
//           return fileName; // Return the uploaded file name
//         }
//       } else {
//         print('Error uploading files : ${uploadResponse.statusCode}');
//         throw Exception('Error uploading files : ${uploadResponse.statusCode}');
//       }
//     } catch (e) {
//       print('Error uploading file: $e');
//       return null;
//     }
//   }

//   Future<void> updateImageField(
//     String fileName,
//     String object,
//     String id,
//     String field,
//   ) async {
//     // Get the access token and baseUrl
//     String? token = await storage.read(key: "access_token");

//     try {
//       final String apiUrl = '${baseUrls}/$object/$id';

//       // Make the PATCH request to update the image field
//       final logoUpdateResponse = await http.patch(
//         Uri.parse(apiUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//         body: {field: fileName}, // Use the extracted file name here
//       );

//       // Check the response status code for logo update
//       if (logoUpdateResponse.statusCode == 200) {
//         print('Logo updated successfully!');
//       } else {
//         print('Error updating logo: ${logoUpdateResponse.statusCode}');
//       }
//     } catch (e) {
//       print('Error updating logo: $e');
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hayya_traya7/config.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class FilePickerUploader extends ChangeNotifier {
  File? _imageFile;
  String? _fileNameR;
  bool _update = true;
  bool get isupdate => _update;
  String? get fileNameR => _fileNameR;
  File? get imageFile => _imageFile;

  void setImageFile(File? file) {
    _imageFile = file;
    print("Image file set: $file");
    _update = false;
    notifyListeners();
  }

  Future<String?> pickAndUploadFile({
    required String dynamicPath,
    required String id,
    required String object,
    required String field,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        print('File picked: ${file.name}');
        File image = File(file.path!);
        setImageFile(image);

        String? uploadedFileName = await uploadFile(
          file: image,
          dynamicPath: dynamicPath,
          object: object,
          id: id,
          field: field,
        );

        if (uploadedFileName != null) {
          return uploadedFileName;
        }
      } else {
        print('User canceled the picker');
      }
    } catch (e) {
      print('Error picking and uploading file: $e');
    }
    notifyListeners();

    return null;
  }

  Future<String?> uploadFile({
    required File file,
    required String dynamicPath,
    required String object,
    required String id,
    required String field,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String brear_token = prefs.getString('token') ?? '';
      print('Token : ${brear_token}');
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${defaultBaseUrls}api/users/update/profile'),
      );

      request.headers.addAll({'Authorization': 'Bearer ${brear_token}'});
      request.fields['path'] = dynamicPath;

      var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'files',
        stream,
        length,
        filename: path.basename(file.path),
      );
      request.files.add(multipartFile);

      var uploadResponse = await request.send();

      if (uploadResponse.statusCode == 201) {
        var responseBody = await uploadResponse.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);

        var fileNames = jsonResponse['fileNames'];
        if (fileNames != null && fileNames.isNotEmpty) {
          var fileName = fileNames[0];
          print('File uploaded successfully! File Name: $fileName');
          await updateImageField(fileName, object, id, field);
          _fileNameR = fileName.toString();
          _update = true;
          notifyListeners();
          return fileName;
        }
      } else {
        print('Error uploading files : ${uploadResponse.statusCode}');
        throw Exception('Error uploading files : ${uploadResponse.statusCode}');
      }
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  Future<void> updateImageField(
    String fileName,
    String object,
    String id,
    String field,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String brear_token = prefs.getString('token') ?? '';

    try {
      final String apiUrl =
          '${'http://192.168.1.8:3500/api/users/update/profile'}/$object/$id';

      var response = await http.patch(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $brear_token'},
        body: {field: fileName},
      );

      if (response.statusCode == 200) {
        print('Field updated successfully: $field');
      } else {
        print('Error updating field $field: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating field $field: $e');
    }
  }
}
