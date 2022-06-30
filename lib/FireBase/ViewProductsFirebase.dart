import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'UpdateProduct_Firebase.dart';

class ViewProductsFirebase extends StatefulWidget {
  @override
  _ViewProductsFirebaseState createState() => _ViewProductsFirebaseState();
}

class _ViewProductsFirebaseState extends State<ViewProductsFirebase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase View Product with image"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Products").snapshots(),
        builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(snapshot.hasData)
              {
                if(snapshot.data.size<=0)
                  {
                    return Center(child: Text("No Data"));
                  }
                else
                  {
                    return ListView(
                      children: snapshot.data.docs.map((document){
                        return Card(
                          color: Colors.blue.shade100,
                          elevation: 10.0,
                          shadowColor: Colors.blue.shade200,
                          margin: EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: Image.network(document["imageurl"]),
                            title: Text(document["name"]),
                            subtitle: Text(document["description"]),
                            trailing:Text(document["sprice"]),
                            onTap: () async{
                              AlertDialog alert = new AlertDialog(
                                title: Text("Delete"),
                                content: Text("Are You Sure Delete Data"),
                                actions: [
                                  TextButton(
                                    child: Text("Edit"),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                      var id = document.id.toString();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => UpdateProduct_Firebase(docid: id))
                                      );
                                    },
                                  ),

                                  TextButton(
                                    onPressed: () async{
                                      var id = document.id.toString();
                                      await FirebaseFirestore.instance.collection("Products").doc(id).delete();
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
                          ),
                        );
                      }).toList(),
                    );
                  }
              }
            else
              {
                return Center(child: CircularProgressIndicator());
              }
          }
      ),
    );
  }
}
