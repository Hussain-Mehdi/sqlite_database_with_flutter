import 'package:flutter/material.dart';
import 'package:sqlite_flutte/compose_message.dart';
import 'package:sqlite_flutte/data/dependency_injection_container.dart';
import 'package:sqlite_flutte/message%20repository/message_repository.dart';
import 'package:sqlite_flutte/message_model.dart';
import 'package:sqlite_flutte/tables_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Message>> messages;
  MessageRepository _messageRepository = MessageRepository();

  getMessages() async {
    messages = _messageRepository.getAll();
  }

  @override
  void initState() {
    getMessages();
    // messages= Message.getAllMessages();
    print("Messages: $messages");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  messages = _messageRepository.getAll();
                });
              },
              icon: const Icon(Icons.refresh)),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TableScreen(),
                    ));
              },
              child: const Text("Show Table"))
        ],
      ),
      body: FutureBuilder(
        future: messages,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text("There was an error:${snapshot.error}");
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No Message available"),
                );
              }
              var messages = snapshot.data;
              return ListView.separated(
                  itemBuilder: (context, index) {
                    Message message = messages![index];
                    return ListTile(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => MessageDetail(Message(message.messageId,message.messageTitle,message.messageDescription)),));
                      },
                      title: Text(message.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message.description),
                          Text(
                            message.date,
                            style: const TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xff3c5158),
                        child: Text(
                          "PJ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ComposeMessage(message),
                                      ));
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  
                                  String status =await locator<MessageRepository>().delete(
                                      message.id ?? 0);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          content: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color.fromARGB(
                                                  255, 18, 76, 109),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  width: 70,
                                                ),
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://cdn-icons-png.freepik.com/512/7518/7518748.png"))),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(status)
                                              ],
                                            ),
                                          )));
                                  messages = await locator<MessageRepository>().getAll();
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: snapshot.data!.length);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComposeMessage(null),
              ));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
