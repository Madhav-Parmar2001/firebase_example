import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UpdateUser_Firebase extends StatefulWidget
{

  var docid = "";
  UpdateUser_Firebase({this.docid});

  @override
  UpdateUser_FirebaseState createState() => UpdateUser_FirebaseState();
}

class UpdateUser_FirebaseState extends State<UpdateUser_Firebase>
{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController user_name = TextEditingController();
  TextEditingController user_contact = TextEditingController();
  TextEditingController user_email = TextEditingController();
  TextEditingController user_password = TextEditingController();

  getsinglerecord() async
  {
    await FirebaseFirestore.instance.collection("User").doc(widget.docid).get().then((document){
      setState(() {
        user_name.text = document["Name"].toString();
        user_contact.text = document["Contact"].toString();
        user_email.text = document["Email"].toString();
        user_password.text = document["Password"].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsinglerecord();
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Edit User"),),
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
                    controller: user_name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      hintText: "Enter Name",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: user_contact,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Contact",
                      hintText: "Enter Contact",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: user_email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "email",
                      hintText: "Enter email",
                    )
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: user_password,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Enter Password",
                    )
                ),

                SizedBox(height: 15,),
                RaisedButton(
                  onPressed: () async{
                    var user_name1 = user_name.text.toString();
                    var user_contact1 = user_contact.text.toString();
                    var user_email1 = user_email.text.toString(); // Retail Price (Mrp)
                    var user_password1 = user_password.text.toString(); // Selling Price (Discount Price)

                    await FirebaseFirestore.instance.collection("User").doc(widget.docid).update({
                      "Name":user_name1,
                      "Contact":user_contact1,
                      "Email":user_email1,
                      "Password":user_password1,
                    }).then((value){
                      Navigator.of(context).pop();
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
