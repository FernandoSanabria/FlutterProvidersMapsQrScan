import 'package:enero4ejemplo1/src/provider/provider_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatefulWidget {

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {

    final changedStatus =Provider.of<ProviderStatus>(context);


    return BottomNavigationBar(
      // type:BottomNavigationBarType.fixed,
      onTap: (value){
        print(value);
        changedStatus.opcionSeleccionada= value;
        // _Body();
      },
      elevation: 0.0,

      currentIndex: changedStatus.opcionSeleccionada,
       items: [
         BottomNavigationBarItem(

           icon:Icon(Icons.map, ),
           label: 'Mapa' 
           ),
         BottomNavigationBarItem(
           icon:Icon(Icons.wifi),
           label: 'Direcciones' 
          ),
         
       ],
    );
  }
}