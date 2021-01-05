import 'package:enero4ejemplo1/src/services/database_service.dart';
import 'package:enero4ejemplo1/src/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class ListViewUrls extends StatefulWidget {
  @override
  _ListViewUrlsState createState() => _ListViewUrlsState();
}

 List<Widget> loadCustomListTile(List<dynamic> data, BuildContext context) {
  final List<Widget> options = [];

  data.forEach((element) {
    final widget = CustomListTile(
      leading: 'map',
      subtitle: element.id.toString(),
      title: element.valor,
    );

    options.add(widget);
  });

  return options;
}


class _ListViewUrlsState extends State<ListViewUrls> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseService.databaseService.getData('http'),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: loadCustomListTile(snapshot.data, context),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
 
  }
}
