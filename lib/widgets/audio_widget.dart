import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioWidget extends StatefulWidget {
  final String audio;

  const AudioWidget({
    super.key,
    required this.audio,
  });

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  final AudioPlayer player = AudioPlayer();

  bool reproduciendo = false;

  Duration posicion = Duration.zero;
  Duration duracion = Duration.zero;

  @override
  void initState() {
    super.initState();

    player.onPositionChanged.listen((p) {
      setState(() {
        posicion = p;
      });
    });

    player.onDurationChanged.listen((d) {
      setState(() {
        duracion = d;
      });
    });

    player.onPlayerComplete.listen((event) {
      setState(() {
        reproduciendo = false;
        posicion = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  String formatear(Duration d) {
    String dos(int n) => n.toString().padLeft(2, '0');

    return "${dos(d.inMinutes)}:${dos(d.inSeconds % 60)}";
  }

  Future<void> reproducirAudio() async {
    await player.play(
      AssetSource(
        'audios/${widget.audio}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: Colors.black,
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            iconSize: 50,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),

            onPressed: () async {
              if (reproduciendo) {
                await player.pause();
              } else {
                if (posicion == Duration.zero) {
                  await reproducirAudio();
                } else {
                  await player.resume();
                }
              }

              setState(() {
                reproduciendo = !reproduciendo;
              });
            },

            icon: Icon(
              reproduciendo
                  ? Icons.pause_circle
                  : Icons.play_circle,
            ),
          ),

          Slider(
            min: 0,
            max: duracion.inSeconds > 0
                ? duracion.inSeconds.toDouble()
                : 1,
            value: posicion.inSeconds
                .clamp(
              0,
              duracion.inSeconds > 0
                  ? duracion.inSeconds
                  : 1,
            )
                .toDouble(),
            onChanged: (value) async {
              await player.seek(
                Duration(
                  seconds: value.toInt(),
                ),
              );
            },
          ),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatear(posicion),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                formatear(duracion),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}