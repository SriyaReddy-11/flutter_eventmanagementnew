import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventsmangers2/models/event_subscribers.dart';
import 'package:eventsmangers2/models/eventsData.dart';
import 'package:eventsmangers2/models/userData.dart';
import 'package:uuid/uuid.dart';


class DatabaseService {
  // collection reference
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection(
      "users");
  final CollectionReference eventsCollection = Firestore.instance.collection(
      "events");

  final CollectionReference eventSubscribersCollection = Firestore.instance.collection(
      "eventSubscribers");


  Future updateUserData(String email, String names, phone_number,
      bool is_organizer, String password) async {
    return await userCollection.document(uid).setData({
      "user_id": uid,
      "email": email,
      "names": names,
      "phone_number": phone_number,
      "is_organizer": is_organizer
    });
  }

  //Userdata list
  List<UserData> _userListFromSnapsht(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
        user_id: doc.data['user_id'] ?? uid,
        email: doc.data['email'] ?? null,
        names: doc.data['name'] ?? null,
        phone_number: doc.data['phone_number'] ?? null,
        is_organizer: doc.data['is_organizer'] ?? null,
        password: doc['data'] ?? null,
      );
    }).toList();
  }

  Stream<List<UserData>> usersById(String user_id) {
    return Firestore.instance.collection('users').where(
        "user_id", isEqualTo: user_id).snapshots()
        .map(_userListFromSnapsht);
  }

  Stream<List<UserData>> allUsers(String user_id) {
    return Firestore.instance.collection('users').snapshots()
        .map(_userListFromSnapsht);
  }

//  Events dta stream


  Future AddEvents(String event_name, String event_description, String photo_url,
      String category, String lat, String lang, DateTime event_date) async {
    var uuid = Uuid();

    // Generate a v1 (time-based) id
    var event_id = uuid.v1();
    return await eventsCollection.document(event_id).setData({
      "event_id": event_id,
      "event_name": event_name,
      "event_description": event_description,
      "photo_url": photo_url,
      "event_category": category,
      "event_date": event_date,
      "latitude": lat,
      "longitude": lang,
    });
  }
  List<EventData> _eventsListFromSnapsht(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return EventData(
        event_id: doc.data['event_id'] ?? uid,
        event_name: doc.data['event_name'] ?? null,
        event_description: doc.data['event_description'] ?? null,
        photo_url: doc.data['photo_url'] ?? null,
        event_category: doc.data['event_category'] ?? null,
        lang: doc.data["lang"] ?? null,
        lat: doc.data["lat"] ?? null,
        event_date: doc['event_date'].toDate(),
      );
    }).toList();
  }

  Stream<List<EventData>> allEvents() {
    return Firestore.instance.collection('events').snapshots()
        .map(_eventsListFromSnapsht);
  }

  Stream<List<EventData>> eventsById(String event_id) {
    return Firestore.instance.collection('events').where(
        "event_id", isEqualTo: event_id).snapshots()
        .map(_eventsListFromSnapsht);
  }


//Subsribers information

  Future AddSubscribers(String user_id, String event_id) async {
    return await eventSubscribersCollection.document(uid).setData({
      "user_id": user_id,
      "event_id": event_id,
    });
  }
  List<EventSubscribersData> _subscribersListFromSnapsht(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return EventSubscribersData(
        event_id: doc.data['event_id'] ?? null,
        user_id: doc.data['user_id'] ?? null,

      );
    }).toList();
  }

  Stream<List<EventSubscribersData>> eventSubscribers(String event_id) {
    return Firestore.instance.collection('eventSubscribers').where(
        "event_id", isEqualTo: event_id).snapshots()
        .map(_subscribersListFromSnapsht);
  }


  Stream<List<EventSubscribersData>> myEvents(String user_id) {
    return Firestore.instance.collection('eventSubscribers').where(
        "user_id", isEqualTo: user_id).snapshots()
        .map(_subscribersListFromSnapsht);
  }


}

  


