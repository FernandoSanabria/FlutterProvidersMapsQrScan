import 'package:enero4ejemplo1/src/services/database_service.dart';
import 'package:enero4ejemplo1/src/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class ListViewMaps extends StatefulWidget {
  @override
  _ListViewMapsState createState() => _ListViewMapsState();
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


class _ListViewMapsState extends State<ListViewMaps> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseService.databaseService.getData('map'),
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
