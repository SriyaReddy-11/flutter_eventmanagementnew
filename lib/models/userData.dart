class UserData{

  final String? user_id;
  final String? email;
  final String? names;
  final String? phone_number;
  final bool? is_organizer;

  final String? password;


  UserData({this.user_id, this.email, this.names, this.phone_number, this.is_organizer, this.password});

  factory UserData.initialData() {
    return UserData(
      user_id: '',
      email: '',
      names: '',
      phone_number: '',
      is_organizer:  true,
      password: '',
    );
  }
}
