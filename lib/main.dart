import 'dart:async';
import 'dart:math' show Random;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_fazt/config/provider.dart';
import 'package:game_fazt/helpers/colors.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Fazt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
      ),
      home: ChangeColor(),
    );
  }
}

class ChangeColor extends ConsumerWidget {
  ChangeColor({super.key});

  final CountdownController controllerCounter = CountdownController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Status statusGame = ref.watch(statusGameProvider);
    final pointsGame = ref.watch(pointsGameProvider);
    final timerCount = ref.watch(timerProvider);
    // color para lso puntos
    final colorRandom = ref.watch(colorRandomProvider);
    final colorBGRandom = ref.watch(colorBGRandomProvider);
    // Color falso
    final colorRandomFalse = ref.watch(colorFalseRandomProvider);
    final colorBGRandomFalse = ref.watch(colorFalseBGRandomProvider);

    dynamic getcolorRandon() {
      final random = Random();
      final text = colorsLevelBasic[random.nextInt(colorsLevelBasic.length)];
      ref.read(colorRandomProvider.notifier).update((state) => text.name);
      ref.read(colorBGRandomProvider.notifier).update((state) => text.bgcolor);
    }

    dynamic getcolorRandonFalse() {
      final random = Random();
      final text = colorsLevelBasic[random.nextInt(colorsLevelBasic.length)];
      ref.read(colorFalseRandomProvider.notifier).update((state) => text.name);
      ref
          .read(colorFalseBGRandomProvider.notifier)
          .update((state) => text.bgcolor);
    }

    void nextColor(color) {
      ColorItem newColorRandom;
      ColorItem newColorRandomFalse;
      // Selecciona nuevos colores hasta que sean diferentes
      do {
        newColorRandom =
            colorsLevelBasic[Random().nextInt(colorsLevelBasic.length)];
        newColorRandomFalse =
            colorsLevelBasic[Random().nextInt(colorsLevelBasic.length)];
      } while (newColorRandom.name == newColorRandomFalse.name);
      if (color == colorRandom) {
        ref.watch(pointsGameProvider.notifier).state += 1;
      } else {
        if (pointsGame != 0) {
          ref.watch(pointsGameProvider.notifier).state -= 1;
        }
      }
      ref
          .read(colorRandomProvider.notifier)
          .update((state) => newColorRandom.name);
      ref
          .read(colorBGRandomProvider.notifier)
          .update((state) => newColorRandom.bgcolor);
      ref
          .read(colorFalseRandomProvider.notifier)
          .update((state) => newColorRandomFalse.name);
      ref
          .read(colorFalseBGRandomProvider.notifier)
          .update((state) => newColorRandomFalse.bgcolor);
    }

    void startGame() {
      if (statusGame == Status.pause) {
        controllerCounter.restart();
        ref.watch(pointsGameProvider.notifier).state = 0;
      }
      controllerCounter.start();
      ref.read(statusGameProvider.notifier).update((state) => Status.playing);
      getcolorRandon();
      getcolorRandonFalse();
    }

    List<Widget> shuffleList(List<Widget> list) {
      final random = Random();
      for (var i = list.length - 1; i > 0; i--) {
        final j = random.nextInt(i + 1);
        final temp = list[i];
        list[i] = list[j];
        list[j] = temp;
      }
      return list;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('Game Fast'),
          centerTitle: true,
        ),
        backgroundColor: const Color.fromARGB(255, 236, 236, 236),
        body: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Puntos $pointsGame',
                          style: const TextStyle(
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(width: 60),
                        Countdown(
                            controller: controllerCounter,
                            seconds: timerCount,
                            build: (_, double time) {
                              return Text(
                                'Segundos ${time.toInt()} ',
                                style: const TextStyle(
                                  fontSize: 28,
                                ),
                              );
                            },
                            onFinished: () {
                              ref.read(statusGameProvider.notifier).state =
                                  Status.pause;
                            })
                      ]),
                ),
                Text(
                  statusGame == Status.pause
                      ? 'Jugar'
                      : colorRandom.toString().toUpperCase(),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 5,
                    color: statusGame == Status.pause
                        ? Colors.black
                        : colorBGRandom,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: statusGame == Status.pause
                      ? FilledButton.icon(
                          icon: const Icon(Icons.play_circle),
                          onPressed: () {
                            startGame();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blueAccent)),
                          label: const Text(
                            'Iniciar',
                          ))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: shuffleList([
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              15)), // Esto elimina el redondeo de las esquinas
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          colorBGRandomFalse),
                                ),
                                onPressed: () {
                                  nextColor(colorRandom);
                                },
                                child: SizedBox(
                                    width: 110,
                                    height: 110,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          colorRandom.toString().toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: colorBGRandom),
                                        ))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          colorBGRandom),
                                ),
                                onPressed: () {
                                  nextColor(colorBGRandomFalse!);
                                },
                                child: SizedBox(
                                    width:
                                        110, // Ajusta el ancho según tu preferencia
                                    height:
                                        110, // Ajusta el alto según tu preferencia
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          colorRandomFalse
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: colorBGRandomFalse),
                                        ))),
                              ),
                            ),
                          ]),
                        ),
                ),
              ]),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
