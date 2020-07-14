
class PrayerTimeModels{
  String date,fajr,sunrise,dhuhr,asr,magrib,isha;

  PrayerTimeModels({this.date, this.fajr, this.sunrise, this.dhuhr, this.asr,
      this.magrib, this.isha});


  PrayerTimeModels.frommap(dynamic map){
    this.date=map['DATEPRAYER'];
    this.fajr=map['FAJR'];
    this.sunrise=map['SUNRISE'];
    this.dhuhr=map['DHUHR'];
    this.asr=map['ASR'];
    this.magrib=map['MAGRIB'];
    this.isha=map['ISHA'];
  }

}