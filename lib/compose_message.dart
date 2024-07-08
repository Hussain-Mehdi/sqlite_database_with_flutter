import 'package:flutter/material.dart';
import 'package:sqlite_flutte/message%20repository/message_repository.dart';
import 'package:sqlite_flutte/message_model.dart';

class ComposeMessage extends StatefulWidget {
  ComposeMessage(this._messsage,{super.key});
  final Message? _messsage;

  @override
  State<ComposeMessage> createState() => _ComposeMessageState();
}

class _ComposeMessageState extends State<ComposeMessage> {
  TextEditingController to = TextEditingController();

  TextEditingController message = TextEditingController();

  MessageRepository _messageRepository = MessageRepository();

  @override
  void initState() {
    if(widget._messsage!=null)
    {
    to.text=widget._messsage!.title;
    message.text=widget._messsage!.description;

    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: to,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          TextField(
            controller: message,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          ElevatedButton(onPressed: () {
            if(widget._messsage!=null)
            {
              //_messageRepository.updateMessage(Message(null, to.text, message.text, widget._messsage!.date));
            }
            else{
            _messageRepository.add(Message(null, to.text,message.text, DateTime.now().toString()));

            }
          }, child: const Text("Save"))
        ],
      ),
    );
  }
}
