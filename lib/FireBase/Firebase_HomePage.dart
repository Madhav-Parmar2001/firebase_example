
import 'package:firebase_example/Google_Auth/GoogleLogin.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Notifications/Local_Notification.dart';
import 'AddImage_Firebase.dart';
import 'AddProduct_Firebase.dart';
import 'AddUser_Firebase.dart';
import '../Notifications/Cloud_Notification.dart';
import 'ViewProductsFirebase.dart';
import 'ViewUserFirebase.dart';

class Firebase_HomePage extends StatefulWidget
{
  @override
  _Firebase_HomePageState createState() => _Firebase_HomePageState();
}

class _Firebase_HomePageState extends State<Firebase_HomePage>
{

  var name="";
  var email="";
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  _setValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("Name");
    email = prefs.getString("Email");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setValue();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Home"),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Welcome, Guest!"),
              accountEmail: Text("test@gmail.com"),
            ),
            // ListTile(
            //   leading: Icon(Icons.arrow_forward_ios),
            //   title: Text("Add Product"),
            //   onTap: (){
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => AddProduct_Firebase(),)
            //     );
            //   },
            // ),
            // Divider(),

            // ListTile(
            //   leading: Icon(Icons.arrow_forward_ios),
            //   title: Text("View Product"),
            //   onTap: (){
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => ViewProductsFirebase(),)
            //     );
            //   },
            // ),
            // Divider(),

            ListTile(
              leading: Icon(Icons.arrow_forward_ios),
              title: Text("Add User"),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddUser_Firebase(),)
                );
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.arrow_forward_ios),
              title: Text("View User"),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ViewUserFirebase(),)
                );
              },
            ),
            Divider(),

            // ListTile(
            //   leading: Icon(Icons.arrow_forward_ios),
            //   title: Text("Add Product With Image"),
            //   onTap: (){
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => AddImage_Firebase(),)
            //     );
            //   },
            // ),
            // Divider(),

            // ListTile(
            //   leading: Icon(Icons.arrow_forward_ios),
            //   title: Text("Local Notification"),
            //   onTap: (){
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => Local_Notification(),)
            //     );
            //   },
            // ),
            // Divider(),
            //
            // ListTile(
            //   leading: Icon(Icons.arrow_forward_ios),
            //   title: Text("Local Notification"),
            //   onTap: (){
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => Cloud_Notification(),)
            //     );
            //   },
            // ),
            // Divider(),


          ],
        ),
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name,style: TextStyle(fontSize: 30),),
            SizedBox(height: 15,),
            Text(email,style: TextStyle(fontSize: 30),),
            SizedBox(height: 30,),

            RaisedButton(
              child: Text("LogOut"),
              onPressed: () async{
                await _googleSignIn.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GoogleLogin(),));
              },
            ),
          ],
        ),
      ),

    );
  }
}
