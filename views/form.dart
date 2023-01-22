import 'package:dev_mobile_tp/controllers/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormScreen extends ConsumerWidget {
  // final provTabs = FutureProvider<Map<String, dynamic>>((ref) async {
  //   return await Api().getTable(tName: ref.watch(tableNameProvider));
  // });
  final dataProvider;
  FormScreen({Key? key, required Map<String, dynamic> commingData})
      : dataProvider =
            StateProvider<Map<String, dynamic>>((ref) => commingData),
        super(key: key);
  List<TextEditingController?> controllers = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> data = ref.watch(dataProvider);
    // AsyncValue<Map<String, List>> tabs = ref.watch(provTabs);
    print(data);
    return Scaffold(
      appBar: AppBar(title: Text("Edit ${data["name"]}")),
      body: data["values"] == null
          ? const SizedBox.shrink()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                    itemCount: data["values"]!.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      if (index != 0) {
                        TextEditingController? valuedController =
                            TextEditingController(
                                text: "${data["values"]![index]}");
                        controllers.add(valuedController);
                        return TextField(
                          controller: valuedController,
                        );
                      }
                      return const SizedBox.shrink();
                    })),
                SizedBox(
                  width: 140,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () async {
                        List<String> vals = [];
                        //for(int i=)
                        await Api().updateTable(data: data);
                      },
                      child: const Text("Save")),
                ),
              ],
            ),
    );
  }
}
