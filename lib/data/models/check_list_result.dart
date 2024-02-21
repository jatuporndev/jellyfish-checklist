class CheckListResult {
  String? id;
  String? title;
  String? detail;
  bool? isCheck;

  CheckListResult({
     this.id,
     this.title,
     this.detail,
     this.isCheck,
  });

  factory CheckListResult.fromMap(Map<String, dynamic> map, String id) {
    return CheckListResult(
      id: id,
      title: map['title'],
      detail: map['detail'],
      isCheck: map['isCheck'],
    );
  }
}
