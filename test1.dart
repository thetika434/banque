import 'dart:io';

void main() {
  var gestionnaire = Gestion();

  while (true) {
    print("============= FlexBanque =============");
    print(" 1. creer un compte ");
    print(" 2. faire un depot ");

    print(" 3. lister tous les comptes");
    print(" 4. rechercher un compte");
    print(" 5. quiter");
    print("entrer votre choix");
    final choix = stdin.readLineSync();

    // 1. le premier cas (ajouter un user)
    if (choix == "1") {
      print("entrer votre nom");
      String name = String_verification(stdin.readLineSync() ?? '');
      print("creer un numero de compte");
      int account_number = null_verification(
        int.tryParse(stdin.readLineSync() ?? ''),
      );
      print("veuillez confirmer le code entrer");
      int code_confirm = null_verification(
        int.tryParse(stdin.readLineSync() ?? ''),
      );
      while (code_confirm != account_number) {
        print(" [ERRUER] le code entrer n'est pas correct ressayer !");
        code_confirm = null_verification(
          int.tryParse(stdin.readLineSync() ?? ''),
        );
      }
      gestionnaire.add_user(
        name,
        account_number,
      ); //ajouter un nouvel utilisateur

      print("enregitrement effectuer avec succes !");
    }
    //2. faire un depot
    else if (choix == "2") {
      print("veuillez entrer votre numero de compte");
      int account_number = null_verification(
        int.tryParse(stdin.readLineSync() ?? ''),
      );
      var user = gestionnaire.rechercherUser(account_number);
      if (user == null) {
        print("[ERREUR] compte non trouve ");
      } else {
        user.deposer(account_number);
      }
    }
    // 3.afficher les utilisateurs
    else if (choix == "3") {
      gestionnaire.displayUser();
    }
    // rechercher un utilisateur
    else if (choix == "4") {
      stdout.write("entrer le numero de compte");
      int num = null_verification(int.tryParse(stdin.readLineSync() ?? ''));
      Client? user = gestionnaire.rechercherUser(num);
      if (user == null) {
        print(" [ERRUER] compte non trouver");
      } else {
        print("compte trouver !");
        print(
          "Nom : ${user.name} | n de compte : ${user.account_number} | solde : ${user.solde} FCFA ",
        );
      }
    }
    // quiter la session
    else if (choix == "5") {
      print("merci d'avoir utiliser flexBanque. Au revoir ! ");
      break;
    } else {
      print('entrer un nombre valide');
      continue;
    }
  }
}

// la classe pour representer le client

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
        "[SUCCES] depot de ${moneyRemove} effectue avec succes . Nouveau solde : ${this.solde} ",
      );
    }
  }
}

//class pour la gestion des clients
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
}

// fonction pour verifier si le nonmbre entrer par l'utilisateur est reellement un nombre et l'obliger a en entrer un
int null_verification(int? number) {
  while (number == null) {
    print(" svp entrer quelque chose de valide ");
    number = int.tryParse(stdin.readLineSync() ?? "");
  }
  ;
  return number;
}

// .fonction pour empecher l'utilisateur d'entrer a la place d'une chaine un entier ou une chaine vide
String String_verification(String word) {
  while (word.isEmpty || int.tryParse(word) != null) {
    print("entrer quelque chose de correct");
    word = stdin.readLineSync() ?? '';
  }
  return word;
}
