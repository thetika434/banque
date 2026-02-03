void main() {
  var etudaunt1 = Etudiant("thetika", 18);
}

class Etudiant {
  String name;
  int age;
  Etudiant(this.name, this.age);

  Map<String, dynamic> convert() {
    return {"name": this.name, "age": this.age};
  }
}
