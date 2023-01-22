import 'package:dev_mobile_tp/controllers/api.dart';
import 'package:dev_mobile_tp/models/auth.dart';
import 'package:dev_mobile_tp/views/chat_screen.dart';
import 'package:dev_mobile_tp/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  final String title;
  final provTabs = FutureProvider<List<dynamic>>((ref) async {
    return await Api().getWorkers();
    // return [
    //   {
    //     "id": 1,
    //     "username": "person 1",
    //     "avatar":
    //         "https://www.shutterstock.com/image-photo/surreal-image-african-elephant-wearing-260nw-1365289022.jpg"
    //   },
    //   {
    //     "id": 2,
    //     "username": "person 2",
    //     "avatar": "https://tinypng.com/images/social/website.jpg"
    //   }
    // ];
  });
  MainScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<dynamic>> tabs = ref.watch(provTabs);
    int id = ref.watch(tableNameProvider);
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, actions: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthModel().logout();
              Navigator.pop(context);
            },
          ),
        ]),
        body: Center(
          child: Column(
            children: [
              ListView.builder(
                  itemCount: tabs.value?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(tabs.value![index]["username"]),
                        leading: Avatar(
                          url: '${tabs.value![index]["avatar"]}',
                          userId: tabs.value![index]["id"],
                        ),
                        onTap: (() {
                          ref
                              .read(tableNameProvider.notifier)
                              .update((state) => tabs.value![index]["id"]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()),
                          );
                        }),
                      ),
                    );
                  })),
            ],
          ),
        ));
  }
}
