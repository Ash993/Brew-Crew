import 'package:brewcrew/module/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brewcrew/module/brew.dart';


class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection =Firestore.instance.collection('brews');



  Future updateUserData(String sugars, String name, int strength )  async{
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,

    });
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['sstrength'],
    );
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name']?? '',
        strength: doc.data['strength']??0,
        sugars: doc.data['sugars']??'',
      );
    }).toList();

  }
  //get brews Stream
  Stream<List<Brew>>  get brews{
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);


  }
  //get user doc stream
  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}





