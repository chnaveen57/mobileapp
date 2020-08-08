class Screen {
  String id;
  String name;
  String theaterId;
  List<String> timeSlots;
  String movieId;
  Screen({this.id, this.movieId, this.name, this.timeSlots,this.theaterId});
  factory Screen.fromJson(Map<String, dynamic> json) {
    return Screen(
      id: json['PartitionKey'],
      name: json['name'],
      timeSlots: json['screens'].toString().split(" "),
      movieId: json['movies'],
      theaterId: json['theaterId']
    );
  }
}
