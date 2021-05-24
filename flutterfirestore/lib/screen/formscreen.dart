import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirestore/model/product.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FormScreen extends StatefulWidget {
  FormScreen({Key key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  Product myProduct = Product();
  //set firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  //สร้างตาราง
  CollectionReference _productCollection =
      FirebaseFirestore.instance.collection("products");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text("รายการสินค้า"),
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ชื่อสินค้า",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        validator:
                            RequiredValidator(errorText: "กรุณากรอกให้ครบ"),
                        onSaved: (String pname) {
                          myProduct.pname = pname;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "ราคาสินค้า",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        validator:
                            RequiredValidator(errorText: "กรุณากรอกให้ครบ"),
                        onSaved: (String price) {
                          myProduct.price = price;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "บริษัทที่ผลิต",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        validator:
                            RequiredValidator(errorText: "กรุณากรอกให้ครบ"),
                        onSaved: (String comp) {
                          myProduct.comp = comp;
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            "บันทึกข้อมูล",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              await _productCollection.add({
                                "pname": myProduct.pname,
                                "price": myProduct.price,
                                "comp": myProduct.comp
                              });
                              formKey.currentState.reset();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      future: firebase,
    );
  }
}
