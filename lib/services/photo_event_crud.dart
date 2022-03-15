import 'package:nontourage/models/photo_event.dart';

abstract class PhotoEventCRUD {
  Future createAppointment(PhotoEvent event);
  Future deleteAppointment(String eventKey);
  Future replaceAppointment(PhotoEvent event);
  Future updateAppointment(PhotoEvent event);
}