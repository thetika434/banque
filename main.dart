import 'dart:io';
import 'client.dart';
import 'gestion.dart';
import 'validators.dart';

void main() {
  var gestionnaire = Gestion();

  while (true) {
    print("============= FlexBanque =============");
    print(" 1. creer un compte ");
    print(" 2. faire un depot ");
    print(" 3. faire un retrait");
    print(" 4. lister tous les comptes");
    print(" 5. rechercher un compte");
    print(" 6. quiter");
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
      gestionnaire.add_user(name, account_number);
      gestionnaire.saveData(); //ajouter un nouvel utilisateur

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
        print("entrer le montant a deposer");
        int moneyAdd = null_verification(
          int.tryParse(stdin.readLineSync() ?? ''),
        );
        user.deposer(moneyAdd);
      }
    }
    //3. faire un retrait
    else if (choix == "3") {
      print("veuillez entrer votre numero de compte");
      int account_number = null_verification(
        int.tryParse(stdin.readLineSync() ?? ''),
      );
      var user = gestionnaire.rechercherUser(account_number);
      if (user == null) {
        print("[ERREUR] compte non trouve ");
      } else {
        print("entrer le montant a retirer");
        int moneyRemove = null_verification(
          int.tryParse(stdin.readLineSync() ?? ''),
        );
        user.retrait(moneyRemove);
      }
    }
    // 4.afficher les utilisateurs
    else if (choix == "4") {
      gestionnaire.displayUser();
    }
    // 5. rechercher un utilisateur
    else if (choix == "5") {
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
    // 6. quiter la session
    else if (choix == "6") {
      print("merci d'avoir utiliser flexBanque. Au revoir ! ");
      break;
    } else {
      print('entrer un nombre valide');
      continue;
    }
  }
}
