import 'package:flutter/material.dart';

class ChordPage extends StatefulWidget{


  @override
  State<ChordPage> createState() => _ChordPageState();
}

class _ChordPageState extends State<ChordPage> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text('ChordPage'),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child:
        Column(
          children: [

          ],
        ),
      ),
    );
  }
}