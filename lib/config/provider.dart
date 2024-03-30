import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Status { pause, playing }

final statusGameProvider = StateProvider<Status>((ref) => Status.pause);

final colorRandomProvider = StateProvider<dynamic>((ref) => '');
final colorBGRandomProvider = StateProvider<dynamic>((ref) => Colors.white);
//Falso select
final colorFalseRandomProvider = StateProvider<dynamic>((ref) => '');
final colorFalseBGRandomProvider =
    StateProvider<dynamic>((ref) => Colors.white);

final pointsGameProvider = StateProvider<int>((ref) => 0);
final timerProvider = StateProvider<int>((ref) => 25);
