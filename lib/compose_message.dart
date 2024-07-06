import 'package:flutter/material.dart';

class ComposeMessage extends StatelessWidget {
  ComposeMessage({super.key});
  TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: text,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          ElevatedButton(onPressed: () {

            
          }, child: const Text("Save"))
        ],
      ),
    );
  }
}
