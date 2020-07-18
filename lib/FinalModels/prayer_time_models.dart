
class PrayerTimeModels{
  String date,fajr_start,fajr_end,israk,dhuhr,asr,magrib,aoyabin,isha;

  PrayerTimeModels({this.date, this.fajr_start, this.fajr_end,this.israk, this.dhuhr, this.asr,
      this.magrib, this.isha,this.aoyabin});


  PrayerTimeModels.frommap(dynamic map){
    this.date=map['DATEPRAYER'];
    this.fajr_start=map['FAJR_START'];
    this.fajr_end=map['FAJAR_END'];
    this.israk=map['ISRAK'];
    this.dhuhr=map['DHUHR'];
    this.asr=map['ASR'];
    this.magrib=map['MAGRIB'];
    this.aoyabin=map['AOYABIN'];
    this.isha=map['ISHA'];
  }

}