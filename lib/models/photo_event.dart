class PhotoEvent{
  String hostUID;
  DateTime dateTime;
  String eventMessage;
  dynamic eventPhotos ;
  PhotoEvent({required this.hostUID, required this.dateTime,
    required this.eventMessage});
}

class HostedEvent extends PhotoEvent{
  HostedEvent({required String hostUID,
    required DateTime dateTime, required String eventMessage})
      : super(hostUID: hostUID, dateTime: dateTime, eventMessage: eventMessage);

}

class AttendingEvent extends PhotoEvent{
  AttendingEvent({required String hostUID, required DateTime dateTime,
    required String eventMessage})
      : super(hostUID: hostUID, dateTime: dateTime, eventMessage: eventMessage);


}