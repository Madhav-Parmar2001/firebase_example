
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddUser_Firebase extends StatefulWidget {
  @override
  AddUser_FirebaseState createState() => AddUser_FirebaseState();
}

class AddUser_FirebaseState extends State<AddUser_Firebase> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController user_name = TextEditingController();
  TextEditingController user_contact = TextEditingController();
  TextEditingController user_email = TextEditingController();
  TextEditingController user_password = TextEditingController();

  PickedFile imagesfile = null;
  File images = null;

  getcamera() async {
    final PickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imagesfile = PickedFile;
      images = File(imagesfile.path);
    });
  }

  getgallery() async {
    final PickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imagesfile = PickedFile;
      images = File(imagesfile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Add User with Images"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          color: Colors.blue.shade50,
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                (images != null)
                    ? Image.file(images)
                    : Text("No Image Availble"),

                ElevatedButton(
                  child: Text("Camera"),
                  onPressed: () {
                    getcamera();
                  },
                ),

                ElevatedButton(
                  child: Text("Gallery"),
                  onPressed: () {
                    getgallery();
                  },
                ),

                SizedBox(
                  height: 5,
                ),

                TextFormField(
                    controller: user_name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      hintText: "Enter Name",
                    )),
                SizedBox(
                  height: 15,
                ),

                TextFormField(
                    controller: user_contact,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Contact",
                      hintText: "Enter Contact",
                    )),
                SizedBox(
                  height: 15,
                ),

                TextFormField(
                    controller: user_email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "email",
                      hintText: "Enter email",
                    )),
                SizedBox(
                  height: 15,
                ),

                TextFormField(
                    controller: user_password,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Enter Password",
                    )),

                SizedBox(
                  height: 15,
                ),
                RaisedButton(
                  onPressed: () async {
                    var user_name1 = user_name.text.toString();
                    var user_contact1 = user_contact.text.toString();
                    var user_email1 =
                        user_email.text.toString(); // Retail Price (Mrp)
                    var user_password1 = user_password.text
                        .toString(); // Selling Price (Discount Price)

                    //Random File Name
                    Random random = new Random();
                    String imagesname = random.nextInt(100).toString() + ".jpg";

                    await FirebaseStorage.instance
                        .ref(imagesname)
                        .putFile(images)
                        .whenComplete(() {})
                        .then((addimagesdata) async {
                      await addimagesdata.ref
                          .getDownloadURL()
                          .then((imageslink) async {
                        await FirebaseFirestore.instance
                            .collection("User")
                            .add({
                          "Name": user_name1,
                          "Contact": user_contact1,
                          "Email": user_email1,
                          "Password": user_password1,
                          "imagesname": imagesname,
                          "imagesurl": imageslink,
                        }).then((value) {
                          print("User Data Inserted to Firebase");
                          user_name.text = "";
                          user_contact.text = "";
                          user_email.text = "";
                          user_password.text = "";
                        });
                      });
                    });

                    // await FirebaseFirestore.instance.collection("User").add({
                    //   "Name": user_name1,
                    //   "Contact": user_contact1,
                    //   "Email": user_email1,
                    //   "Password": user_password1,
                    // }).then((value){
                    //   print("User Data Inserted to Firebase");
                    //   user_name.text = "";
                    //   user_contact.text = "";
                    //   user_email.text = "";
                    //   user_password.text = "";
                    // });
                  },
                  color: Colors.blue,
                  child: Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
