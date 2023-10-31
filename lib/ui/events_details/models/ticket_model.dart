class TicketModel{
  String id;
  String? uId;
  TicketModel({
    required this.id,
    this.uId
});
  factory TicketModel.fromJson(Map<String,dynamic> json){
    return TicketModel(
        id: json['id'],
        uId: json['uId']
    );
  }
}