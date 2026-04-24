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
    var file = File('comptes.json');
    String jsonText = jsonEncode(newList); // transforme un objet en String

    file.writeAsStringSync(jsonText);
    // print(" l'utilisateur vient d'etre en registrer en dur");
  }

  void loadData() {
    final file = File('comptes.json');

    // On vérifie si le fichier existe pour éviter de faire planter le programme
    if (file.existsSync()) {
      try {
        // 1. On lit le texte brut (le String JSON)
        String textJson = file.readAsStringSync();

        // 2. On transforme ce texte en une liste de Maps dynamiques
        List<dynamic> jsonList = jsonDecode(textJson);
        data_base = jsonList
            .map(
              (e) => Client(
                name: e['name'],
                account_number: e['account_number'],
                solde: e['solde'],
              ),
            )
            .toList();

        // 3. On transforme chaque Map en un véritable objet "Client"
        // C'est ici qu'on reconstruit notre base de données en RAM

        print(
          "\x1B[32m[SYSTÈME] ${data_base.length} comptes chargés avec succès.\x1B[0m",
        );
      } catch (e) {
        print(
          "\x1B[31m[ERREUR] Impossible de lire le fichier de sauvegarde : $e\x1B[0m",
        );
      }
    }
  }
}
