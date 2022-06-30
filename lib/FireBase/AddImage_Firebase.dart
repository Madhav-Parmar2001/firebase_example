import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage_Firebase extends StatefulWidget
{
  @override
  AddImage_FirebaseState createState() => AddImage_FirebaseState();
}

class AddImage_FirebaseState extends State<AddImage_Firebase>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController product_name = TextEditingController();
  TextEditingController product_descrption = TextEditingController();
  TextEditingController product_rprice = TextEditingController();
  TextEditingController product_sprice = TextEditingController();

  PickedFile imageFile=null;
  File image=null;

  getcamera() async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera ,
    );
    setState(() {
      imageFile = pickedFile;
      image  = File(imageFile.path);
    });
  }
  getgallery() async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );
    setState(() {
      imageFile = pickedFile;
      image  = File(imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Add Image"),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          color: Colors.blue.shade50,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                (image!=null)?Image.file(image):Text("No Image"),

                ElevatedButton(
                  onPressed: (){
                    getcamera();
                  },
                  child: Text("Camera"),
                ),

                ElevatedButton(
                  onPressed: (){
                    getgallery();
                  },
                  child: Text("Gallery"),
                ),

                SizedBox(height: 5,),
                TextFormField(
                    controller: product_name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      hintText: "Enter Name",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: product_descrption,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Description",
                      hintText: "Enter Description",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: product_rprice,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "R Price",
                      hintText: "Enter R Price",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: product_sprice,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "S Price",
                      hintText: "Enter S Price",
                    )
                ),
                SizedBox(height: 15,),
                RaisedButton(
                  onPressed: () async{
                    var name = product_name.text.toString();
                    var description = product_descrption.text.toString();
                    var rprice = product_rprice.text.toString(); // Retail Price (Mrp)
                    var sprice = product_sprice.text.toString(); // Selling Price (Discount Price)


                    //File image
                    Random random = new Random();
                    String imagename = random.nextInt(9999).toString()+".jpg"; //4526.jpg


                    await FirebaseStorage.instance.ref(imagename).putFile(image).whenComplete((){}).then((filedata) async{
                      await filedata.ref.getDownloadURL().then((imagelink) async{
                        await FirebaseFirestore.instance.collection("Products").add({
                          "name":name,
                          "description":description,
                          "rprice":rprice,
                          "sprice":sprice,
                          "imagename":imagename,
                          "imageurl":imagelink
                        }).then((value){
                          print("Product Data Inserted to Firebase");
                          product_name.text="";
                          product_descrption.text="";
                          product_rprice.text="";
                          product_sprice.text="";
                        });
                      });
                    });
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
