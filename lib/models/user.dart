class User {
  String name;
  String id;
  String photoUrl;
  User({this.id, this.name, this.photoUrl});
  User.initial()
      : id = '',
        name = '',
        photoUrl = '';
}
