import 'package:flutter/material.dart';
import 'package:untitled5/widgets/head.dart';
import 'package:untitled5/widgets/list.dart';
import 'package:untitled5/widgets/home.dart';
import 'package:untitled5/models/data.dart';
class Attendance extends StatefulWidget{
  const Attendance({super.key});
  @override
  State<Attendance> createState(){
      return _AttendanceState();
  }
}

class _AttendanceState extends State<Attendance>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Manager'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))

        ],
      ),
      body: Column(
        children: [
              Heading(),
        ],
      ),
    );

  }
}