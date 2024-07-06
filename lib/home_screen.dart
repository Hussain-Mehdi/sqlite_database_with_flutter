import 'package:flutter/material.dart';
import 'package:sqlite_flutte/compose_message.dart';
import 'package:sqlite_flutte/message_model.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Message> messages=[];

@override
  void initState()async {
    messages=await Message.getAllMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile();
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount:messages.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComposeMessage(),
              ));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
