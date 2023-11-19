class TicketModel {
  String? id;
  String? eId;
  String? uId;

  TicketModel({required this.id, required this.eId, required this.uId});

  factory TicketModel.fromJson(Map<String, dynamic>? json) {
    return TicketModel(id: json?['id'], eId: json?['eId'], uId: json?['uId']);
  }

  Map<String, dynamic> toJson() => {"id": id, "eId": eId, "uId": uId};
}
