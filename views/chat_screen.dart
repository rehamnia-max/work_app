import 'package:dev_mobile_tp/controllers/api.dart';
import 'package:dev_mobile_tp/views/form.dart';
import 'package:dev_mobile_tp/widgets/message.dart';
import 'package:dev_mobile_tp/widgets/msg_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tableNameProvider = StateProvider<int>((ref) => 0);

class ChatScreen extends ConsumerWidget {
  final provTabs = FutureProvider<Map<String, dynamic>>((ref) async {
    final lst = [
      {"msg": "Salam 1", "time": 1565888474278, "reciver": true},
      {"msg": "Salam 2", "time": 1565888474278, "reciver": false},
      {"msg": "Salam 3", "time": 1565888474278, "reciver": true},
      {"msg": "Salam 4", "time": 1565888474278, "reciver": false},
    ].reversed.toList();
    return {
      "id": 1,
      "name": "person 1",
      "phone": "0653264515",
      "avatar":
          "https://www.shutterstock.com/image-photo/surreal-image-african-elephant-wearing-260nw-1365289022.jpg",
      "msgs": lst
    };
    // return await Api().getTable(tName: ref.watch(tableNameProvider));
  });
  ChatScreen({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();
  final TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int id = ref.watch(tableNameProvider);
    AsyncValue<Map<String, dynamic>> tabs = ref.watch(provTabs);

    return SafeArea(
        child: Scaffold(
      appBar: MessageAppBar(
          avatarUrl: tabs.value!["avatar"],
          username: tabs.value!["name"],
          phone: tabs.value!["phone"],
          userId: tabs.value!["id"]),
      body: Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemBuilder: (context, index) => MessageWidget(
              message: tabs.value!["msgs"][index]["msg"],
              reciver: tabs.value!["msgs"][index]["reciver"],
              time: tabs.value!["msgs"][index]["time"],
            ),
            itemCount: tabs.value!["msgs"].length,
            reverse: true,
            controller: scrollController,
          )), //Chat list
          Container(
            color: const Color(0xeef1f1f1),
            child: Row(children: [
              Flexible(
                child: TextField(
                  maxLines: 2,
                  style: const TextStyle(fontSize: 15.0),
                  controller: msgController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Type a message',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                  onPressed: () => {},
                ),
              ),
            ]),
          ),
        ],
      ),
    ));
    // return Scaffold(
    //   appBar: AppBar(title: Text(name)),
    //   body: tabs.value == null
    //       ? const SizedBox.shrink()
    //       : Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Expanded(
    //               child: Container(
    //                 color: Colors.red,
    //                 child: ListView.builder(
    //                     itemCount: tabs.value?["columns"]!.length ?? 0,
    //                     shrinkWrap: true,
    //                     scrollDirection: Axis.horizontal,
    //                     itemBuilder: ((context, index) {
    //                       return Text(tabs.value?["columns"]![index]);
    //                     })),
    //               ),
    //             ),
    //             Expanded(
    //               flex: 20,
    //               child: ListView.builder(
    //                   itemCount: tabs.value?["data"]!.length ?? 0,
    //                   shrinkWrap: true,
    //                   itemBuilder: ((context, index0) {
    //                     return //Text(tabs.value?["data"]![index0][0]);
    //                         SizedBox(
    //                       height: 50,
    //                       child: ListView.builder(
    //                           itemCount:
    //                               tabs.value?["data"]![index0].length ?? 0,
    //                           shrinkWrap: true,
    //                           scrollDirection: Axis.horizontal,
    //                           itemBuilder: ((context, index1) {
    //                             return GestureDetector(
    //                               onTap: () {
    //                                 Map<String, dynamic> data = {
    //                                   "name": name,
    //                                   "values": tabs.value?["data"]![index0]
    //                                 };
    //                                 // ref
    //                                 //     .read(dataProvider.notifier)
    //                                 //     .update((state) => data);
    //                                 Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                         builder: (context) => FormScreen(
    //                                               commingData: data,
    //                                             )));
    //                               },
    //                               child: Text(
    //                                   "${tabs.value?["data"]![index0][index1]}"),
    //                             );
    //                           })),
    //                     );
    //                   })),
    //             ),
    //           ],
    //         ),
    // );
  }
}
