
class User{
  int? userId;
  final String username;
  final String password;
  final String role;

  User({
    required this.username,
    required this.password,
    required this.role
  });

  User.fromJson(Map<String, dynamic> json):
    userId = json["userId"] is int ? json["userId"] : int.tryParse(json["userId"].toString()),
    username = json["username"] ?? "",
    password = json["password"] ?? "", 
    role = json["role"] ?? "";

static Map<String, dynamic> toJson(User value) =>
{
   "id": value.userId,
   "username": value.username, 
   "password": value.password,
   "roler": value.role
};
  
}