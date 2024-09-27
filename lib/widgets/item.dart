import 'package:flutter/material.dart';
import 'package:untitled5/models/data.dart';
class Item extends StatelessWidget {
  const Item(this.datass, {super.key});
  final Data datass;
  String get safe{
    num a=datass.attended ;
    num b=datass.total;
    if ((a/b)*100<75){
      return "Ohh no, you are  in trouble you need to attend next";
    }
    else{
      return "On Track, You may leave next";
    }
  }
  num get attend{
    num a=datass.attended;
    num b=datass.total;
    num c=0;
    if ((a/b)*100<75) {
        while ((a / b) * 100 < 75) {
          a++;
          b++;
          c++;
        }
    }
    else{
      while ((a / b) * 100 >= 75) {
        b++;
        c++;
      }
      c--;

    }
    return c;
  }
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 1,

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(datass.name),
          const SizedBox(height: 4),
          Text("Attended: ${datass.attended}/${datass.total} classes"),
          const SizedBox(height: 4),
          Text("Status : ${safe.toString()} ${attend.toString()} classes")
        ],
      ),
    ),);
  }
}