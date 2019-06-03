class Status {
  int ownerId;
  String text;
  String dateOfChange;
  String dateOfChangeTitle;

  Status(this.ownerId, this.text, this.dateOfChange, this.dateOfChangeTitle);

  Status.fromJson(Map<String, dynamic> json) :
        ownerId = json['ownerId'],
        text = json['text'],
        dateOfChange = json['dateOfChange'],
        dateOfChangeTitle = json['dateOfChangeTitle'];

  Map<String, dynamic> toJson() => {
        'ownerId': ownerId,
        'text': text,
        'dateOfChange': dateOfChange,
        'dateOfChangeTitle': dateOfChangeTitle,
      };
}