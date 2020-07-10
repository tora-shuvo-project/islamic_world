class QuranWordModels{

  int serial_no;
  String image_url;
  String percent_complete;
  String taskNumber;

  QuranWordModels({this.serial_no, this.image_url, this.percent_complete, this.taskNumber});

  QuranWordModels.fromMap(dynamic map){
    this.serial_no=map['SERIAL_NO'];
    this.image_url=map['IMAGE_URL'];
    this.percent_complete=map['PERCENT_COMPLETE'];
    this.taskNumber=map['TASK_NUMBER'];
  }

}