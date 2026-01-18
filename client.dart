import 'validators.dart';
import 'dart:io';

class Client {
  String name;
  int account_number;
  int solde;
  Client({required this.name, required this.account_number, this.solde = 0});

  // methode pour deposer de l'argent

  void deposer(int moneyAdd) {
    while (moneyAdd < 0) {
      print("votre solde doit etre positif ! (ressayer) : ");
      moneyAdd = null_verification(int.tryParse(stdin.readLineSync() ?? ''));
    }
    this.solde += moneyAdd;
    print(
      "[SUCCES] depot de ${moneyAdd} effectue avec succes . Nouveau solde : ${this.solde} ",
    );
  }
  // methode pour faire un retrait

  void retrait(int moneyRemove) {
    while (moneyRemove < 0) {
      print("votre solde doit etre positif ! (ressayer) : ");
      moneyRemove = null_verification(int.tryParse(stdin.readLineSync() ?? ''));
    }
    if (moneyRemove > this.solde) {
      print(
        "solde insuffisant impossible de faire un retrait (veuillez ressayer)",
      );
    } else {
      this.solde -= moneyRemove;
      print(
        "[SUCCES] retrait  de ${moneyRemove} effectue avec succes . Nouveau solde : ${this.solde} ",
      );
    }
  }

  // Methode to convert objects in map

  Map<String, dynamic> tojson() {
    return {
      'name': this.name,
      'account_number': this.account_number,
      'solde': this.solde,
    };
  }
}
