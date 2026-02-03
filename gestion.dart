import 'dart:io';

import 'client.dart';
import 'dart:convert';

class Gestion {
  List<Client> data_base = [];
  // 1. fonction pour ajouter  un  utilisateur
  void add_user(String name, int number_account) {
    var le_client = Client(name: name, account_number: number_account);
    data_base.add(le_client); //ajouter l'objet dans la liste
  }

  // 2. fonction pour afficher toutes les infos liees aux utilisateurs
  void displayUser() {
    print("\n========= LISTE DES CLIENTS =========");
    if (data_base.isEmpty) {
      print("il n'ya pas encore de clients dans la base de donnee");
    } else {
      for (var client in data_base) {
        print(
          "Nom : ${client.name} | n de compte : ${client.account_number} | solde : ${client.solde} FCFA ",
        );
      }
    }
  }

  // 3. fonction pour rechercher un client en fonction de son account_number
  Client? rechercherUser(int num) {
    try {
      // on utilise le try car au cas ou on ne trouve pas l'objet rechercher dans notre liste cela declenchera une erreur et nous capturons cette erreur pour l'eteindre
      return data_base.firstWhere(
        (Client) => Client.account_number == num,
      ); // c'est la technique pour trouver un objet dans une liste qui a une caracteristique specifique que nous connaissons
    } catch (e) {
      return null;
    }
  }

  void saveData() {
    List<Map<String, dynamic>> newList = data_base
        .map((client) => client.tojson())
        .toList();
    final file = File('comptes.json');
    String textJson = jsonEncode(newList);
    file.writeAsStringSync(textJson);
    print("vous avez etet enregistrer en dur");
  }
}
