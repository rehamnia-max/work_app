import 'package:dev_mobile_tp/controllers/api.dart';
import 'package:dev_mobile_tp/views/chat_screen.dart';
import 'package:dev_mobile_tp/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  final int profileId;
  final ScrollController scrollController = ScrollController();
  ProfilePage({Key? key, required this.profileId}) : super(key: key);
  final worksDataRevo = StateProvider<List<Map<String, dynamic>>>((ref) {
    return [
      {"": 0}
    ];
  });
  final profileDataRevo = FutureProvider<Map<String, dynamic>>((ref) async {
    Map<String, dynamic> res =
        await Api().getWorker(ref.watch(tableNameProvider));
    print(res);
    return res;
    // {
    //   "id": 1,
    //   "username": "person 1",
    //   "phone": "0653264515",
    //   "work_set": [],
    //   "avatar":
    //       "https://www.shutterstock.com/image-photo/surreal-image-african-elephant-wearing-260nw-1365289022.jpg",
    // };
    // return await Api().getTable(tName: ref.watch(tableNameProvider));
  });

  Future<void> setWorksSet(ref, profileData) async {
    ref.read(worksDataRevo.notifier).update((state) async {
      final works_ids = profileData.value!["work_set"];
      List<Map<String, dynamic>> resu = [];
      for (int i = 0; i < works_ids.length; i++) {
        resu.add(await Api().getWork(works_ids[i]));
      }
      print("this is works of ${profileData.value!["username"]} : $resu");
      return resu;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Map<String, dynamic>> profileData = ref.watch(profileDataRevo);

    setWorksSet(ref, profileData);

    print(ref.watch(profileDataRevo));
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: _TopPortion(
                url: profileData.value!["avatar"],
              )),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    profileData.value!["username"],
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () async {
                          await FlutterPhoneDirectCaller.callNumber(
                              profileData.value!["phone"]);
                        },
                        heroTag: 'follow',
                        elevation: 0,
                        label: const Text("Call"),
                        icon: const Icon(Icons.phone_enabled),
                      ),
                      const SizedBox(width: 16.0),
                      FloatingActionButton.extended(
                        onPressed: () {
                          ref
                              .read(tableNameProvider.notifier)
                              .update((state) => profileId);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()),
                          );
                        },
                        heroTag: 'mesage',
                        elevation: 0,
                        backgroundColor: Colors.red,
                        label: const Text("Message"),
                        icon: const Icon(Icons.messenger_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const _ProfileInfoRow()
                ],
              ),
            ),
          ),
          Flexible(
              flex: 4,
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemBuilder: (context, index) {
                  //
                  return Card(
                    elevation: 2.0,
                    child: SizedBox(
                      height: 20,
                    ),
                  );
                },
                itemCount: 20,
                reverse: true,
                controller: scrollController,
              )),
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Posts", 900),
    ProfileInfoItem("Followers", 120),
    ProfileInfoItem("Following", 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
                    child: Row(
                  children: [
                    if (_items.indexOf(item) != 0) const VerticalDivider(),
                    Expanded(child: _singleItem(context, item)),
                  ],
                )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  final String url;
  const _TopPortion({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(url)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
