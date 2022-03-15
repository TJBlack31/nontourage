import "package:cloud_firestore/cloud_firestore.dart";
import 'package:nontourage/models/photo_event.dart';
import 'package:nontourage/services/photo_event_crud.dart';

class DatabaseService implements PhotoEventCRUD{
  final String uid;

  DatabaseService({required this.uid});
  
  final CollectionReference appointmentCollection =
    FirebaseFirestore.instance.collection('appointments');

  Future updateUserData(String location, String name, int attendees) async {
    return await appointmentCollection.doc(uid).set({
        'name' : name,
        'location' : location,
        'attendees' : attendees
    });
  }

  @override
  Future createAppointment(PhotoEvent event) async {
    return await appointmentCollection.doc(event.hostUID).set(event);
    throw UnimplementedError();
  }

  @override
  Future deleteAppointment(String eventKey) {
    // TODO: implement deleteAppointment
    throw UnimplementedError();
  }

  @override
  Future replaceAppointment(PhotoEvent event) {
    // TODO: implement replaceAppointment
    throw UnimplementedError();
  }

  @override
  Future updateAppointment(PhotoEvent event) {
    // TODO: implement updateAppointment
    throw UnimplementedError();
  }

}