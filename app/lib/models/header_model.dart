class ChildProfile {
  int? id;
  final String name;
  final String age;
  final String imageUrl;
  final DateTime currentDate;

  ChildProfile({
    required this.name,
    required this.age,
    required this.imageUrl,
    required this.currentDate,
  });

  ChildProfile.fromJson(Map<String, dynamic> json):
   id = json["id"],
   name = json["name"],
   age = json["age"],
   imageUrl = json["imageUrl"],
   currentDate = DateTime.parse(json["currentDate"]);

   @override
   toString(){
      return "name $name - age: $age";
   }

}

var childProfileHeader = ChildProfile(
      name: 'Maria Laura',
      age: '2 anos',
      imageUrl: 'images/perfil.jpg', // Substitua pela URL da foto
      currentDate: DateTime.now(),
);