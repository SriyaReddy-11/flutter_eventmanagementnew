

class EventData{

  final String? event_id;
  final String? event_name;
  final String? event_description;
  final String? photo_url;
  final String? event_category;
  final String? lat;
  final String? lang;

  final DateTime? event_date ;


  EventData({this.event_id, this.event_name, this.event_description, this.photo_url, this.event_category, this.lat, this.lang, this.event_date});


  factory EventData.initialData() {
    return EventData(
      event_id: '',
      event_name: '',
      event_description: '',
      photo_url: '',
      event_category:  '',
      lang: '',
      lat: '',
      event_date: null,
    );
  }


}
