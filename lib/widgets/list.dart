import 'package:flutter/material.dart';
import 'package:untitled5/models/data.dart';
import 'package:untitled5/widgets/item.dart';
class AttendanceList extends StatelessWidget{
  const AttendanceList({super.key,required this.datas});
  final List<Data> datas;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: datas.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (ctx,index) => Item(datas[index]));
  }
}