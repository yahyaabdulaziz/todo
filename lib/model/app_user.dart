import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/tododm.dart';

class AppUser {
  static const collectionName = "users";
  late String id;
  late String username;
  late String email;
  static AppUser? currentUser;

  AppUser({required this.id, required this.username, required this.email});

  AppUser.fromJson(Map json) {
    id = json["id"];
    username = json["username"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
    };
  }

  static CollectionReference<AppUser> collection() {
    return FirebaseFirestore.instance
        .collection(AppUser.collectionName)
        .withConverter<AppUser>(fromFirestore: (snapshot, _) {
      return AppUser.fromJson(snapshot.data()!);
    }, toFirestore: (user, _) {
      return user.toJson();
    });
  }

  static CollectionReference getCurrentUserTodosCollection() {
    return AppUser.collection()
        .doc(AppUser.currentUser!.id)
        .collection(TodosModel.collectionName);
  }
}
