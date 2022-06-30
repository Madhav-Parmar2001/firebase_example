
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProduct_Firebase extends StatefulWidget
{
  @override
  AddProduct_FirebaseState createState() => AddProduct_FirebaseState();
}

class AddProduct_FirebaseState extends State<AddProduct_Firebase>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController product_name = TextEditingController();
  TextEditingController product_descrption = TextEditingController();
  TextEditingController product_rprice = TextEditingController();
  TextEditingController product_sprice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Add Product"),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          color: Colors.blue.shade50,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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

                    await FirebaseFirestore.instance.collection("Products").add({
                      "name":name,
                      "description":description,
                      "rprice":rprice,
                      "sprice":sprice,
                    }).then((value){
                      print("Product Data Inserted to Firebase");
                      product_name.text="";
                      product_descrption.text="";
                      product_rprice.text="";
                      product_sprice.text="";
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
