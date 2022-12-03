// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:proy_taller/constant.dart';
import 'package:proy_taller/models/api_response.dart';
import 'package:proy_taller/models/children.dart';
import 'package:proy_taller/screens/login.dart';
import 'package:proy_taller/services/children_service.dart';
import 'package:proy_taller/services/user_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> _childrenList = [];
  bool _loading = true;

  Future<void> retrieveChildren() async {
    ApiResponse response = await getChildren();
    if (response.error == null) {
      setState(() {
        _childrenList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    }
    else if (response.error == unauthorized) {
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (route) => false)
      });
    }
  }

  @override
  void initState() {
    retrieveChildren();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
          ),
          child: const Center(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: InputBorder.none
              ),
            ),
          ),
        ),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              logout().then((value) => {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (route) => false)
              });
            },
          )
        ]
      ),
      body: _loading ? const Center(child: CircularProgressIndicator(),)
      : ListView.builder(
        itemCount: _childrenList.length,
        itemBuilder: (BuildContext context, int index) {
          Children child = _childrenList[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            child: Column
          );
        }
      )
    );
  }
}