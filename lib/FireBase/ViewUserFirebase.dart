import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'UpdateUser_Firebase.dart';

class ViewUserFirebase extends StatefulWidget
{
  @override
  _ViewUserFirebaseState createState() => _ViewUserFirebaseState();
}

class _ViewUserFirebaseState extends State<ViewUserFirebase>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase View User "),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("User").snapshots(),
          builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(snapshot.hasData)
              {
                if(snapshot.data.size<=0)
                  {
                    return Center(child: Text("No Data"),);
                  }
                else
                  {
                    return ListView(
                      children: snapshot.data.docs.map((document){
                        return GestureDetector(
                          child: Card(
                            color: Colors.blue.shade100,
                            elevation: 10.0,
                            shadowColor: Colors.blue.shade200,
                            margin: EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(child: Image.network(document["imagesurl"],height: 50.0,width: 50.0,),),
                                    ],
                                  ),
                                  SizedBox(width: 20.0,),
                                  
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Name",style: TextStyle(fontSize: 15.0,),),
                                      Text("Contact",style: TextStyle(fontSize: 15.0,),),
                                      Text("Email",style: TextStyle(fontSize: 15.0,),),
                                      Text("Password",style: TextStyle(fontSize: 15.0,),),
                                    ],
                                  ),
                                  SizedBox(width: 20.0,),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(":",style: TextStyle(fontSize: 15.0,)),
                                      Text(":",style: TextStyle(fontSize: 15.0,),),
                                      Text(":",style: TextStyle(fontSize: 15.0,),),
                                      Text(":",style: TextStyle(fontSize: 15.0,),),
                                    ],
                                  ),
                                  SizedBox(width: 20.0,),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(document["Name"],style: TextStyle(fontSize: 15.0,),),
                                      Text(document["Contact"],style: TextStyle(fontSize: 15.0,),),
                                      Text(document["Email"],style: TextStyle(fontSize: 15.0,),),
                                      Text(document["Password"],style: TextStyle(fontSize: 15.0,),),
                                    ],
                                  ),
                                  SizedBox(height: 30.0,),
                                ],
                              ),
                            ),
                          ),
                          onTap: () async {
                            AlertDialog alert = AlertDialog(
                              title: Text("Delete"),
                              content: Text("Are You Sure Delete Data"),
                              actions: [
                                TextButton(
                                  child: Text("Edit"),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                    var id = document.id.toString();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => UpdateUser_Firebase(docid: id,)),
                                    );
                                  },
                                ),

                                TextButton(
                                  onPressed: () async{
                                    var id = document.id.toString();
                                    await FirebaseFirestore.instance.collection("User").doc(id).delete();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Yes"),
                                ),

                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No"),
                                ),
                              ],
                            );
                            showDialog(context: context, builder: (context){
                              return alert;
                            });
                          },
                        );
                      }).toList(),
                    );
                  }
              }
            else
              {
                return Center(child: CircularProgressIndicator(),);
              }
          }
      ),
    );
  }


}
