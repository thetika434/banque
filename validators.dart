import 'dart:io';

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
