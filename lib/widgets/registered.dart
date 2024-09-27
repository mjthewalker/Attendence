import 'package:flutter/material.dart';
import 'package:untitled5/models/data.dart';
import 'package:untitled5/widgets/home.dart';
import 'package:untitled5/widgets/list.dart';
class GetRegi extends StatelessWidget{
  const GetRegi(this.regis, {super.key});
  final List<Data> regis;
  @override
  Widget build(BuildContext context) {
    return Expanded(child: AttendanceList(datas: regis));
  }
}