import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nails_app/providers/cliente.dart';
import 'package:nails_app/screens/rutas.dart';
import 'package:nails_app/services/usuario_services.dart';
import 'package:provider/provider.dart';

class SignupScreem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuarioFrom = Provider.of<ClienteService>(context);
    return ChangeNotifierProvider(
        create: (_) => ClienteProvider(usuarioFrom.usuario),
        child: _SignupScrenBody(userService: usuarioFrom));
  }
}

class _SignupScrenBody extends StatelessWidget {
  final ClienteService userService;

  const _SignupScrenBody({Key? key, required this.userService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final altura = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Forma(),
          Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: altura * .15),
                      child: DesignWidgets.tituloDark(context)),
                  Padding(
                      padding: EdgeInsets.only(top: altura * .05),
                      child: _FromUsuario()),
                  _signupLabel(context),
                ],
              ),
            ),
          ),
          Positioned(top: altura * .025, child: MyBotton()),
        ],
      )),
    );
  }

  Widget _signupLabel(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, 'signin'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(TextApp.CON_CUENTA,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey)),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              TextApp.SIGNIN,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}

class _FromUsuario extends StatefulWidget {
  @override
  State<_FromUsuario> createState() => _FromUsuarioState();
}

class _FromUsuarioState extends State<_FromUsuario> {
  bool _visibilidad = true;
  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<ClienteProvider>(context);
    final userService = Provider.of<ClienteService>(context);

    final userNuevo = userForm.user;
    return Form(
      key: userForm.keyDelUsuario,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nombre',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(padding: const EdgeInsets.only(top: 10)),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onChanged: (value) => userNuevo.nombre = value,
            validator: (value) {
              if (value != null && value.length > 0) {
                return null;
              } else {
                return "Ingrese su nombre!";
              }
            },
          ),
          Text(
            'Apellido',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(padding: const EdgeInsets.only(top: 10)),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onChanged: (value) => userNuevo.apellido = value,
            validator: (value) {
              if (value != null && value.length > 0) {
                return null;
              } else {
                return "Ingrese su Apellido!";
              }
            },
          ),
          Text(
            'Celula de identidad',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(padding: const EdgeInsets.only(top: 10)),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onChanged: (value) {
              if (value.isNotEmpty) {
                userNuevo.telefono = int.parse(value);
              }
            },
            validator: (value) {
              if (value != null && value.length > 0) {
                return null;
              } else {
                return "Ingrese su Carnet!";
              }
            },
          ),
          Text(
            'Telefono',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(padding: const EdgeInsets.only(top: 10)),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onChanged: (value) {
              if (value.isNotEmpty) {
                userNuevo.telefono = int.parse(value);
              }
            },
            validator: (value) {
              if (value != null && value.length > 0) {
                return null;
              } else {
                userNuevo.telefono = 0;
              }
            },
          ),
          Text(
            'Direccion',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(padding: const EdgeInsets.only(top: 10)),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onChanged: (value) => userNuevo.direccion = value,
            validator: (value) {
              if (value != null && value.length > 0) {
                return null;
              } else {
                return "Ingrese su direccion";
              }
            },
          ),
          Text(
            'Email',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(padding: const EdgeInsets.only(top: 10)),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onChanged: (value) => userNuevo.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = new RegExp(pattern);
              if (regExp.hasMatch(value ?? "")) {
                return null;
              } else {
                return "Ingrese un correo valido";
              }
            },
          ),
          Text(
            'Contraseña',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(padding: const EdgeInsets.only(top: 10)),
          TextFormField(
            obscureText: _visibilidad,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                suffixIcon: CupertinoButton(
                    child: Icon(
                        _visibilidad
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {
                      _visibilidad = !_visibilidad;
                      setState(() {});
                    }),
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onChanged: (value) => userNuevo.pass = value,
            validator: (value) {
              if (value != null && value.length > 6) {
                return null;
              } else {
                return "Ingrese una contraseña mayor a 6 caracteres!";
              }
            },
          ),
          Text(
            'Confirmar Contraseña',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(padding: const EdgeInsets.only(top: 10)),
          TextFormField(
            obscureText: _visibilidad,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                suffixIcon: CupertinoButton(
                    child: Icon(
                        _visibilidad
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {
                      _visibilidad = !_visibilidad;
                      setState(() {});
                    }),
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            validator: (value) {
              if (value != null && value == userNuevo.pass) {
                return null;
              } else {
                return "Su contraseña no coincide";
              }
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 50.0, bottom: 25),
            width: double.infinity,
            child: ElevatedButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.all(15.0),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (!userForm.esValidadoElFrom()) return;
                  if (userNuevo.direccion!.length > 0) {
                    userForm.estaRegistrado = true;
                    userNuevo.lat = "xd";
                    userNuevo.lon = "xd";
                    userNuevo.precio = "-1";
                    userNuevo.urlImg = "fotoAqui";
                    userNuevo.createdAt = "hoy";
                    userNuevo.updatedAt = "mas tarde";
                    userNuevo.deletedAt = "pasado";
                    final String? respuesta =
                        await userService.crearUsuario(userNuevo);
                    if (respuesta == null) {
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pushReplacementNamed(context, 'signin');
                    } else {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                                title: Text('Lo siento. '),
                                content: Text(respuesta),
                                actions: [
                                  CupertinoDialogAction(
                                      child: Text('Aceptar',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              letterSpacing: 1.5,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      })
                                ],
                              ));
                      userForm.estaRegistrado = false;
                    }
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                              title: Text('Por favor, '),
                              content: Text('Ingrese su genero'),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text('Aceptar',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            letterSpacing: 1.5,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ],
                            ));
                  }
                },
                child: Text(
                  userForm.estaRegistrado ? "Cargando..." : TextApp.SIGNUP,
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }

/*   Widget _selector(List<String> lista, Cliente user, BuildContext context) {
    return DropdownButton(
      hint: Text("-Seleccionar-"),
      onChanged: (String? value) {
        setState(() {
          user.direccion = value!;
          _valorInicial = value;
        });
      },
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 36,
      elevation: 16,
      isExpanded: true,
      underline: Container(height: 3, color: Colors.grey),
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey),
      items: lista.map((e) {
        return DropdownMenuItem(value: e, child: Text(e));
      }).toList(),
      value: _valorInicial,
    );
  } */
}
