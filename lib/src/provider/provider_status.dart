import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProviderStatus extends ChangeNotifier {
  int _opcionSeleccionada = 0;
  int get opcionSeleccionada {
    return this._opcionSeleccionada;
  }

  set opcionSeleccionada(int i) {
    this._opcionSeleccionada = i;
    notifyListeners();
  }
}
