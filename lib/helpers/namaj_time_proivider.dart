
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:libpray/libpray.dart';
import 'package:provider/provider.dart';
import 'package:searchtosu/helpers/provider_helpers.dart';

class NamazTimer with ChangeNotifier {

  // Init settings.
  // Set calculation method to JAKIM (Fajr: 18.0 and Isha: 20.0).
  PrayerCalculationSettings _settings = PrayerCalculationSettings((PrayerCalculationSettingsBuilder b) =>
  b
    ..calculationMethod.replace(CalculationMethod.fromPreset(preset: CalculationMethodPreset.universityOfIslamicSciencesKarachi))
    ..imsakParameter.replace(PrayerCalculationParameter((PrayerCalculationParameterBuilder c) => c..value = 0 ..type = PrayerCalculationParameterType.minutesAdjust))
    ..juristicMethod.replace(JuristicMethod((JuristicMethodBuilder e) => e..preset = JuristicMethodPreset.hanafi ..timeOfShadow = 2))
    ..highLatitudeAdjustment = HighLatitudeAdjustment.angleBased
    ..imsakMinutesAdjustment = 0
    ..fajrMinutesAdjustment = 0
    ..sunriseMinutesAdjustment = 0
    ..dhuhaMinutesAdjustment = 0
    ..dhuhrMinutesAdjustment = 0
    ..asrMinutesAdjustment = 0
    ..maghribMinutesAdjustment = 0
    ..ishaMinutesAdjustment = 0
  );

  PrayerCalculationSettings get prayerCalulationSettings =>_settings;
}