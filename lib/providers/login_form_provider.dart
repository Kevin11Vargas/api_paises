import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {//maneja el estado del formulario de inicio de sesión.
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();//fk Es una clave global para el formulario que se utilizará para validar y manejar el formulario.

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {//Es una variable privada que indica si la aplicación está en un estado de carga. Se accede a través de un getter y un setter público.
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {//imprime el resultado de la validacion del formulario y regresa un valor booleano
    print(formKey.currentState?.validate());

    print('$email - $password');

    return formKey.currentState?.validate() ?? false;
  }
}
