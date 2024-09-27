import 'package:flutter/material.dart';
import 'package:untitled5/widgets/add.dart';
import 'package:untitled5/models/data.dart';
import 'package:untitled5/widgets/home.dart';
import 'package:untitled5/widgets/list.dart';
import 'package:untitled5/widgets/registered.dart';
class Heading extends StatefulWidget{
  const Heading({super.key});

  @override
  State<Heading> createState(){
    return _HeadingState();
  }
}
class _HeadingState extends State<Heading> {
  final List<Data> _registeredData = [

  ];
  double get totalAttendance{
    double sum=0;
    int i;
    for (i=0;i<_registeredData.length;i++){
        sum+=(_registeredData[i].attended/_registeredData[i].total)/_registeredData.length;
    }
    return sum*100;
  }
  void _openAdd(){
    showModalBottomSheet(isScrollControlled: true,context: context, builder: (ctx) => AddNew(onAdd: _addData,));
  }
  void _addData(Data data){
    setState(() {
    _registeredData.add(data);
});
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children:[
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 16,
            ),
            child: Row(
                children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Target: 75%',),
                        const SizedBox(height: 4),
                        Text('Total attendance:${totalAttendance.toStringAsFixed(3)}%'),
                        const SizedBox(height: 4),
                        const Text('Todays Date'),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor:Colors.white,
                              backgroundColor: Colors.green,
                            ),
                            onPressed: _openAdd,
                            child: const Text('Add Subject'),

                        ),

                        const SizedBox(height: 4),
                        const Text('Widgets'),

                      ],


                    ),


                ],
            ),
          ),
        ),
        const SizedBox(height: 4,),
        AttendanceList(datas: _registeredData)
    ]


    );
  }
}
