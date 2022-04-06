
class EventSubscribersData {

  final String? event_id;
  final String? user_id;

  EventSubscribersData({this.event_id, this.user_id});

  factory EventSubscribersData.initialData() {
    return EventSubscribersData(
      event_id: '',
      user_id: ''
    );
  }

}


