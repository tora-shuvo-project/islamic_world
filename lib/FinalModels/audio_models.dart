class AudioModels{
  int suraNo;
  String qareName,qareDetails,suraLink;

  AudioModels();

  AudioModels.fromMap(dynamic map){
    this.suraNo=map['SURANO'];
    this.qareName=map['QARINAME'];
    this.qareDetails=map['QAREDETAILS'];
    this.suraLink=map['SURALINK'];
  }

}