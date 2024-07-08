import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
      late final tables;

      // getTable()async{
      //   tables=await DatabaseService.getAllTables();
      //   print(tables);
      // }
  // @override
  // void initState() {
  //   getTable();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Center(child: Text(tables[1]['name']),)
    
    );
  }
}