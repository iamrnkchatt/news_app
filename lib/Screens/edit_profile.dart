import 'dart:io' as io;

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scnews/Screens/nav_screen.dart';
import 'package:scnews/Services/image_helper.dart';
import 'package:scnews/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import 'dart:math';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  io.File? selectedFile;

  @override
  void initState() {
    nameController.text = Constant.userName;
    emailController.text = Constant.userEmail;
    super.initState();
  }

  void _selectImageFromGallery(BuildContext context) async {
    final pickedFile = await ImageHelper.pickImageFromGallery(context: context, cropStyle: CropStyle.rectangle, title: 'Image');
    if (pickedFile != null) {
      setState(() {
        selectedFile = pickedFile;
      });
      uploadImageToFirebase(context);
    } else {}
  }

  void _selectImageFromCamera(BuildContext context) async {
    final pickedFile = await ImageHelper.pickImageFromCamera(context: context, cropStyle: CropStyle.rectangle, title: 'Image');
    if (pickedFile != null) {
      setState(() {
        selectedFile = pickedFile;
      });
      uploadImageToFirebase(context);
    } else {}
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        _selectImageFromGallery(context);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _selectImageFromCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void uploadImageToFirebase(BuildContext context) async {
    try {
      var rnd = Random();
      var next = rnd.nextDouble() * 1000;
      while (next < 1000) {
        next *= 10;
      }
      DateTime now = DateTime.now();
      String g = ('${now.year}${now.month}${now.day}');
      String formattedDate = DateFormat('kkmmss').format(now);
      String filename = g + formattedDate + next.toInt().toString() + "." + selectedFile!.path.split(".").last;
      print(filename);
      Reference reference = FirebaseStorage.instance.ref();
      UploadTask uploadTask = reference.child('Images/').child(filename).putFile(selectedFile!);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      print(imageUrl);
      Constant.userImage = imageUrl;
      saveData(Constant.userName, false);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Stack(
                    children: [
                      // ,
                      selectedFile != null ? Image.file(selectedFile!, width: 200, height: 200, fit: BoxFit.cover) : Image.network(Constant.userImage, width: 200, height: 200, fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: Container(color: Colors.grey, padding: EdgeInsets.all(8), child: Icon(Icons.camera_alt, color: Colors.black, size: 28))),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: TextFormField(
                    enabled: false,
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.grey, size: 26),
                      hintText: "Email",
                      hintStyle: GoogleFonts.ptSans(fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.grey, size: 26),
                      hintText: "Name",
                      hintStyle: GoogleFonts.ptSans(fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 28),
                Container(
                  width: 120,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(blue)),
                    onPressed: () {
                      if (nameController.text.trim().isNotEmpty || selectedFile != null) {
                        saveData(nameController.text.trim(), true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter name.')));
                      }
                    },
                    child: Text("Submit", style: GoogleFonts.ptSans(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveData(String name, bool isPop) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("user_id");
    Constant.userName = name;
    if (userId != null && userId.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(userEmailKey, Constant.userEmail);
      prefs.setString(userNameKey, Constant.userName);
      prefs.setString(userImageKey, Constant.userImage);
      DatabaseReference db = FirebaseDatabase.instance.reference().child("users");
      db
          .child(userId)
          .set(({
            'email': Constant.userEmail,
            'name': Constant.userName,
            'photourl': Constant.userImage
            //selectedFile.toString()
          }))
          .asStream();
      if (isPop) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile picture updated successfully.')));
      }
    }
  }
}
