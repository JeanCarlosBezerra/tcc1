import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testeagoravaipqp/service/contact_service.dart';
import 'package:testeagoravaipqp/ui/home_page.dart';
import 'package:hardware_buttons/hardware_buttons.dart';

void main() {
  runApp(MaterialApp(
    home: PrimeiraTela(),
    debugShowCheckedModeBanner: false,
  ));
}

class PrimeiraTela extends StatefulWidget {
  @override
  _PrimeiraTelaState createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {

  Utilitarios utilitarios = Utilitarios();
  String _botao;
  StreamSubscription _volumeButtonSubscription;

  @override
  void initState() {
    _volumeButtonSubscription = volumeButtonEvents.listen((VolumeButtonEvent event) {
      setState(() {
        _botao = VolumeButtonEvent.VOLUME_DOWN.toString();
        if (_botao == 'VolumeButtonEvent.VOLUME_DOWN') {
          utilitarios.ligar();
        }
      });
    });
  }

  @override
  void dispose() {
    _volumeButtonSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        appBar: AppBar(
          title: Text("Botão de Emergência"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 300.0,
                        height: 300.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("images/sos.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              onTap: () {
                utilitarios.ligar();
              },
            ),
            RaisedButton(
              child: Text("CONTATOS"),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            RaisedButton(
              child: Text("EMERGÊNCIA!"),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                utilitarios.ligar();
              },
            )
          ],
        ),
      ),
    );
  }
}
