import 'dart:async';

import 'package:flutter_phone_state/flutter_phone_state.dart';
import 'package:path/path.dart';
import 'package:sms/sms.dart';
import 'package:testeagoravaipqp/helpers/contact_helper.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Utilitarios {
  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();



  Future<void> ligar() async {
    await getAllContacts();
    for (int i = 0; i < contacts.length; i++) {
      await FlutterPhoneDirectCaller.callNumber('${contacts[i].phone}');

      SmsSender sender = new SmsSender();
      await sender.sendSms(new SmsMessage('${contacts[i].phone}', 'Socoorro!'));

      await Future.delayed(Duration(minutes: 1));
    }
  }

  Future<void> getAllContacts() async {
    await helper.getAllContacts().then((list) async {
      contacts = list;
    });
  }
}
