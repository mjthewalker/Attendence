import 'package:flutter/material.dart';
import 'package:untitled5/models/data.dart';
import 'package:untitled5/widgets/registered.dart';
class AddNew extends StatefulWidget{
  const AddNew({super.key,required this.onAdd});
  final void Function(Data datas) onAdd;
  @override
  State<AddNew> createState(){
    return _AddNewState();
  }
}
class _AddNewState extends State<AddNew> {
  final _nameController = TextEditingController();
  final _attendedController = TextEditingController();
  final _totalController = TextEditingController();
  void _submitData(){
    final attendedc = int.tryParse(_attendedController.text);
    final totalc = int.tryParse(_totalController.text);

    if (attendedc == null || totalc == null || totalc < attendedc ||  attendedc < 0 || totalc <0 || _nameController.text.trim().isEmpty ){
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text('Please make sure a subject name , no of classes attended and total number of classes was entered.'),
        actions: [
          TextButton(onPressed:(){
            Navigator.pop(ctx);
          },
              child: const Text('Okay'))
        ],
      ),
      );
      return;
    }

    widget.onAdd(Data(name: _nameController.text,attended: attendedc!,total: totalc!));
    Navigator.pop(context);
  }
  @override
  void dispose() {
    _attendedController.dispose();
    _totalController.dispose();
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          Text('Add Subject',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
          const SizedBox(height: 4,),
          TextField(
            controller: _nameController,
            maxLength: 30,
            decoration: const InputDecoration(
              label: Text('Subject Name'),
            ),
          ),
          const SizedBox(height: 4,),
          TextField(
            controller: _attendedController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text('No of Classes Attended'),
            ),
          ),
          const SizedBox(height: 4,),
          TextField(
            controller: _totalController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text('Total number of classes conducted'),
            ),
          ),
          const SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('CANCEL')),

              ElevatedButton(onPressed:
               _submitData,
                child: const Text('ADD',
               ),
                ),

            ],
          ),




        ],
      ),
    );
  }
}