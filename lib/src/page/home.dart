import 'package:enero4ejemplo1/src/page/list_view_maps.dart';
import 'package:enero4ejemplo1/src/page/list_view_urls.dart';
import 'package:enero4ejemplo1/src/provider/provider_status.dart';
import 'package:enero4ejemplo1/src/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:enero4ejemplo1/src/models/random_value_model.dart';
import 'package:enero4ejemplo1/src/services/database_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// final _mapService = MapSample();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever_sharp),
              onPressed: () {
                final changedStatus =
                    Provider.of<ProviderStatus>(context, listen: false);
                final opcionSeleccionada = changedStatus.opcionSeleccionada;
                deleteAllByType(opcionSeleccionada);
              })
        ],
        title: Text('Historial'),
      ),
      body: _Body(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToLocation();
        },
        child: Icon(Icons.filter_center_focus),
      ),
    );
  }

  void deleteAllByType(opcionSeleccionada) async {
    switch (opcionSeleccionada) {
      case 0:
        await DatabaseService.databaseService.deleteAllByType('map');
        setState(() {});
        break;
      case 1:
        await DatabaseService.databaseService.deleteAllByType('http');
        setState(() {});
        break;
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Ha ocurrido un error con la url:  $url';
    }
  }

  Future sendToDatabase(tipo, respuestaQR) async {
    RandomValueModel randomValueModel =
        RandomValueModel(tipo: tipo, valor: respuestaQR);
    await DatabaseService.databaseService.insertData(randomValueModel);
  }

  void goToLocation() async {
    String respuestaQR = await FlutterBarcodeScanner.scanBarcode(
        '#2b778c', 'cancel', false, ScanMode.QR);

    if (respuestaQR != '-1') {
      if (respuestaQR.contains('http')) {
        await sendToDatabase('http', respuestaQR);
        setState(() {
          
        });
        _launchURL(respuestaQR);
      } else {
        var coordinateOne;
        var coordinateTwo;
        coordinateOne = respuestaQR.split(',')[0];
        coordinateTwo = respuestaQR.split(',')[1].trim();

        sendToDatabase('map', respuestaQR);
        setState(() {
          
        });

        Navigator.pushNamed(context, 'map', arguments: {
          'coordinateOne': coordinateOne,
          'coordinateTwo': coordinateTwo
        });
      }
    }
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final changedStatus = Provider.of<ProviderStatus>(context);
    final opcionSeleccionada = changedStatus.opcionSeleccionada;

    switch (opcionSeleccionada) {
      case 0:
        return ListViewMaps();
        break;
      case 1:
        return ListViewUrls();
        break;
      default:
        return ListViewMaps();
    }
  }
}
