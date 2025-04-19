import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),

      ),
      body: TextField(style: TextStyle(
        fontSize: 25
      ),),
    );
  }
}

