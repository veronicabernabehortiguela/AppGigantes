import 'dart:math';
import 'package:flutter/material.dart';
import '../modelos/idioma.dart';
class PantallaDinoLucha extends StatelessWidget {

  final Idioma idioma;

  const PantallaDinoLucha({super.key, required this.idioma});

  @override
  Widget build(BuildContext context) {

    return TeamSelectionScreen(idioma : idioma);
  }
}

// =========================// DINOS// =========================

final List<Map<String, dynamic>> allDinos = [

  {"name": "Tyrannosaurus","color": Colors.redAccent,"hp": 1.0,"mega": false,"attacks": [{"name": "ataque_mordisco","damage": 0.12,"accuracy": 90,"critChance": 20,"color": Colors.red,},{"name": "ataque_carga","damage": 0.15,"accuracy": 75,"critChance": 35,"color": Colors.orange,},{"name": "ataque_ultra","damage": 0.25,"accuracy": 60,"critChance": 50,"color": Colors.purple,},{"name":"ataque_rugido_rex","damage":0.18,"accuracy":85,"critChance":25,"color":Colors.deepOrange,},]},

  {"name": "Spinosaurus","color": Colors.blue,"hp": 1.0,"mega": false,"attacks": [{"name": "ataque_mordisco_marino","damage": 0.11,"accuracy": 95,"critChance": 15,"color": Colors.blue,},{"name": "ataque_cola_salvaje","damage": 0.14,"accuracy": 80,"critChance": 25,"color": Colors.cyan,},{"name": "ataque_mega_ola","damage": 0.24,"accuracy": 65,"critChance": 45,"color": Colors.indigo,},{"name":"ataque_tsunami","damage":0.18,"accuracy":85,"critChance":25,"color":Colors.lightBlue,},]},

  {"name": "Ankylosaurus","color": Colors.green,"hp": 1.0,"mega": false,"attacks": [{"name": "ataque_mazazo","damage": 0.13,"accuracy": 90,"critChance": 15,"color": Colors.green,},{"name": "ataque_golpe_cola","damage": 0.16,"accuracy": 75,"critChance": 30,"color": Colors.lime,},{"name": "ataque_impacto_brutal","damage": 0.26,"accuracy": 55,"critChance": 55,"color": Colors.brown,},{"name":"ataque_armadura_viva","damage":0.18,"accuracy":85,"critChance":25,"color":Colors.teal,},]},

  {"name": "Velociraptor","color": Colors.deepOrange,"hp": 1.0,"mega": false,"attacks": [{"name": "ataque_garra_rapida","damage": 0.10,"accuracy": 95,"critChance": 25,"color": Colors.orange,},{"name": "ataque_salto_salvaje","damage": 0.14,"accuracy": 80,"critChance": 35,"color": Colors.deepOrange,},{"name": "ataque_ataque_alfa","damage": 0.23,"accuracy": 65,"critChance": 50,"color": Colors.redAccent,},{"name":"ataque_ataque_furtivo","damage":0.18,"accuracy":85,"critChance":35,"color":Colors.orangeAccent,},]},

  {"name": "Triceratops","color": Colors.brown,"hp": 1.0,"mega": false,"attacks": [{"name": "ataque_cornada","damage": 0.12,"accuracy": 90,"critChance": 20,"color": Colors.brown,},{"name": "ataque_embestida","damage": 0.16,"accuracy": 75,"critChance": 30,"color": Colors.deepOrange,},{"name": "ataque_triple_cuerno","damage": 0.25,"accuracy": 60,"critChance": 45,"color": Colors.red,},{"name":"ataque_carga_triple","damage":0.18,"accuracy":85,"critChance":25,"color":Colors.brown,},]},

  {"name": "Brachiosaurus","color": Colors.lightGreen,"hp": 1.0,"mega": false,"attacks": [{"name": "ataque_cuello_latigo","damage": 0.11,"accuracy": 95,"critChance": 15,"color": Colors.lightGreen,},{"name": "ataque_pisada_gigante","damage": 0.15,"accuracy": 75,"critChance": 30,"color": Colors.green,},{"name": "Colapso Titan","damage": 0.26,"accuracy": 55,"critChance": 50,"color": Colors.teal,},{"name":"ataque_pisoton_colosal","damage":0.18,"accuracy":85,"critChance":25,"color":Colors.greenAccent,},]},


  {"name": "Pterodactyl","color": Colors.purpleAccent,"hp": 1.0,"mega": false,"attacks": [{"name": "ataque_picotazo_aereo","damage": 0.10,"accuracy": 95,"critChance": 25,"color": Colors.purple,},{"name": "ataque_tornado_de_alas","damage": 0.15,"accuracy": 80,"critChance": 35,"color": Colors.deepPurple,},{"name": "ataque_caida_supersonica","damage": 0.24,"accuracy": 60,"critChance": 50,"color": Colors.indigo,},{"name":"ataque_vuelo_rasante","damage":0.18,"accuracy":85,"critChance":25,"color":Colors.deepPurpleAccent,},]},

  {"name": "Plesiosaurio","color": Colors.teal,"hp": 1.0,"mega": false,"attacks": [{"name": "ataque_mordisco_marino","damage": 0.11,"accuracy": 95,"critChance": 20,"color": Colors.blue,},{"name": "ataque_latigazo_acuatico","damage": 0.15,"accuracy": 80,"critChance": 30,"color": Colors.cyan,},{"name": "ataque_maremoto_jurasico","damage": 0.25,"accuracy": 60,"critChance": 45,"color": Colors.teal,},{"name":"ataque_corriente_marina","damage":0.18,"accuracy":85,"critChance":25,"color":Colors.cyan,},]},
];

// =========================// SELECCIÓN// =========================

class TeamSelectionScreen extends StatefulWidget {
  final Idioma idioma;
  const TeamSelectionScreen({super.key, required this.idioma});

  @override
  State<TeamSelectionScreen> createState() => _TeamSelectionScreenState();}

class _TeamSelectionScreenState extends State<TeamSelectionScreen> {

  List<Map<String, dynamic>> selectedTeam = [];

  bool isSelected(Map<String, dynamic> dino) {
    return selectedTeam.any((e) => e["name"] == dino["name"]);
  }

  void selectDino(Map<String, dynamic> dino) {

    setState(() {

      final index = selectedTeam.indexWhere(
            (e) => e["name"] == dino["name"],
      );

      if (index != -1) {
        selectedTeam.removeAt(index);
        return;
      }

      if (selectedTeam.length >= 3) return;

      selectedTeam.add({
        "name": dino["name"],
        "color": dino["color"],
        "hp": 1.0,
        "mega": false,
        "attacks":
        List<Map<String, dynamic>>.from(
          dino["attacks"],
        ),
      });

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF10151D),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

               Text(
                widget.idioma.textos["seleccionaEquipo"]!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: ListView.builder(
                  itemCount: allDinos.length,

                  itemBuilder: (context, index) {

                    final dino = allDinos[index];

                    return GestureDetector(
                      onTap: () => selectDino(dino),

                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),

                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(
                          color: dino["color"],
                          borderRadius:
                          BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected(dino)
                                ? Colors.yellow
                                : Colors.transparent,
                            width: 5,
                          ),
                          boxShadow: isSelected(dino)
                              ? [
                            BoxShadow(
                              color: Colors.yellow,
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ]
                              : [],
                        ),

                        child: Row(
                          children: [

                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: isSelected(dino)
                                    ? Colors.yellow
                                    : Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: isSelected(dino)
                                  ? const Icon(
                                Icons.check,
                                color: Colors.black,
                                size: 45,
                              )
                                  : null,
                            ),

                            const SizedBox(width: 20),

                            Expanded(
                              child: Text(
                                dino["name"],

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                width: double.infinity,
                height: 80,

                decoration: BoxDecoration(
                  color: selectedTeam.length == 3
                      ? Colors.redAccent
                      : Colors.grey,

                  borderRadius:
                  BorderRadius.circular(24),
                ),

                child: MaterialButton(
                  onPressed:
                  selectedTeam.length == 3

                      ? () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            BattleScreen(
                              team: selectedTeam,
                              idioma: widget.idioma,
                            ),
                      ),
                    );
                  }

                      : null,

                  child: Text(
                    "${widget.idioma.textos["comenzar"]!} (${selectedTeam.length}/3)",

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }}

// =========================// COMBATE// =========================

class BattleScreen extends StatefulWidget {

  final List<Map<String, dynamic>> team;
  final Idioma idioma;

  const BattleScreen({super.key,required this.team, required this.idioma,});

  @override
  State<BattleScreen> createState() => _BattleScreenState();}

class _BattleScreenState extends State<BattleScreen> {

  late List<Map<String, dynamic>> team;

  late List<Map<String, dynamic>> enemyTeam;

  late Map<String, dynamic> currentDino;

  late Map<String, dynamic> enemy;

  bool showAttacks = false;bool showDinos = false;

  bool playerTurn = true;

  bool megaUsed = false;

  bool enemyMegaUsed = false;

  int meatCount = 3;

  int enemyMeatCount = 3;

  String battleMessage = "";

  double enemyHp = 1.0;

  @override
  void initState() {
    super.initState();

    team = widget.team;

    currentDino = team[0];

    enemyTeam = List.generate(
      3,
          (index) {

        final randomDino =
        allDinos[
        Random().nextInt(
          allDinos.length,
        )
        ];

        return {
          "name": randomDino["name"],
          "color": randomDino["color"],
          "hp": 1.0,
          "mega": false,
          "attacks":
          List<Map<String, dynamic>>.from(
            randomDino["attacks"],
          ),
        };
      },
    );

    enemy = enemyTeam[0];

    enemyHp = enemy["hp"];

    battleMessage =
    widget.idioma.textos["tuTurno"]!;
  }

// =========================// ATAQUE// =========================

  void attackEnemy(Map<String, dynamic> attack) async {

    if (!playerTurn) return;

    setState(() {
      playerTurn = false;
    });

    final random = Random();

    int hitRoll = random.nextInt(100);

    if (hitRoll >= attack["accuracy"]) {

      setState(() {
        battleMessage = widget.idioma.textos["fallo"]!;
      });

      await Future.delayed(
        const Duration(seconds: 1),
      );

      enemyAttack();

      return;
    }

    double damage = attack["damage"];

    bool critical =
        random.nextInt(100) <
            attack["critChance"];

    if (critical) {
      damage *= 1.8;
    }

    setState(() {

      enemyHp -= damage;

      if (enemyHp < 0) {
        enemyHp = 0;
      }

      enemy["hp"] = enemyHp;

      battleMessage = critical
          ? widget.idioma.textos["critico"]!
          :  "${currentDino["name"]} "
          "${widget.idioma.textos["haUsado"]!} "
          "${widget.idioma.textos[attack["name"]]!}";
    });

    if (enemyHp <= 0) {

      enemy["hp"] = 0.0;

      bool enemyAlive =
      enemyTeam.any(
            (d) => d["hp"] > 0,
      );

      if (!enemyAlive) {

        setState(() {
          battleMessage =
          "¡GANASTE!";
        });

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) mostrarFinPartida(true);
        });

        return;
      }

      final nextEnemy =
      enemyTeam.firstWhere(
            (d) => d["hp"] > 0,
      );

      setState(() {

        enemy = nextEnemy;

        enemyHp = enemy["hp"];

        battleMessage =
        widget.idioma.textos["nuevoEnemigo"]!;
      });

      playerTurn = true;

      return;
    }

    await Future.delayed(
      const Duration(seconds: 1),
    );

    enemyAttack();

  }

// =========================// ENEMIGO// =========================

  void enemyAttack() async {

    await Future.delayed(
      const Duration(seconds: 1),
    );

    final random = Random();

    if (!enemyMegaUsed &&
        enemy["hp"] <= 0.6 &&
        random.nextInt(100) < 20) {

      setState(() {
        enemyMegaEvolve();
      });

      await Future.delayed(
        const Duration(seconds: 1),
      );
    }

    if (enemyMeatCount > 0 &&
        enemy["hp"] <= 0.35 &&
        random.nextInt(100) < 25) {

      await enemyUseMeat();

      playerTurn = true;

      setState(() {
        battleMessage = widget.idioma.textos["tuTurno"]!;
      });

      return;
    }


    final attack =
    enemy["attacks"][
    random.nextInt(
      enemy["attacks"].length,
    )
    ];

    double damage = attack["damage"];

    currentDino["hp"] -= damage;

    if (currentDino["hp"] < 0) {
      currentDino["hp"] = 0.0;
    }

    setState(() {
      battleMessage =
      "${enemy["name"]} ${widget.idioma.textos["ataco"]!}";
    });

    if (currentDino["hp"] <= 0) {

      bool teamAlive =
      team.any(
            (d) => d["hp"] > 0,
      );

      if (!teamAlive) {

        setState(() {
          battleMessage =
          "¡PERDISTE!";
        });

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) mostrarFinPartida(false);
        });

        return;
      }

      currentDino =
          team.firstWhere(
                (d) => d["hp"] > 0,
          );
    }

    await Future.delayed(
      const Duration(seconds: 1),
    );

    setState(() {

      playerTurn = true;

      battleMessage =
      widget.idioma.textos["tuTurno"]!;
    });

  }

// =========================// MEGA// =========================

  void useMegaDino() {

    if (megaUsed) return;

    if (currentDino["mega"] == true) return;

    setState(() {

      megaUsed = true;

      currentDino["mega"] = true;

      currentDino["name"] =
      "MEGA ${currentDino["name"]}";

      currentDino["color"] =
          Colors.purple;

      for (var attack
      in currentDino["attacks"]) {

        attack["damage"] *= 1.5;
      }

      battleMessage =
      widget.idioma.textos["megaEvolucion"]!;
    });

  }

  void enemyMegaEvolve() {

    if (enemyMegaUsed) return;

    if (enemy["mega"] == true) return;

    enemyMegaUsed = true;

    enemy["mega"] = true;

    enemy["name"] =
    "MEGA ${enemy["name"]}";

    enemy["color"] =
        Colors.purple;

    for (var attack
    in enemy["attacks"]) {

      attack["damage"] *= 1.5;
    }

    battleMessage =
    widget.idioma.textos["enemigoMega"]!;
  }

// =========================// CURAR// =========================

  void useMeat() async {

    if (!playerTurn) return;

    if (meatCount <= 0) return;

    setState(() {

      playerTurn = false;

      meatCount--;

      currentDino["hp"] += 0.25;

      if (currentDino["hp"] > 1.0) {
        currentDino["hp"] = 1.0;
      }

      battleMessage = widget.idioma.textos["curado"]!;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    enemyAttack();

  }

  Future<void> enemyUseMeat() async {

    if (enemyMeatCount <= 0) return;

    enemyMeatCount--;

    enemy["hp"] += 0.25;

    if (enemy["hp"] > 1.0) {
      enemy["hp"] = 1.0;
    }

    enemyHp = enemy["hp"];

    setState(() {

      battleMessage =
      "${enemy["name"]} ha usado Carne";
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );
  }

// =========================// CAMBIAR DINO// =========================

  void switchDino(Map<String, dynamic> dino) async {

    if (!playerTurn) return;

    if (dino["hp"] <= 0) return;

    setState(() {

      playerTurn = false;

      currentDino = dino;

      showDinos = false;

      battleMessage =
      "¡${dino["name"]}!";
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    enemyAttack();

  }


// =========================
// FIN DE PARTIDA
// =========================

  void mostrarFinPartida(bool victoria) {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A212B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                victoria ? widget.idioma.textos["hasGanado"]! : widget.idioma.textos["hasPerdido"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {

                    Navigator.pop(context);

                    Navigator.pushReplacement(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            TeamSelectionScreen(
                              idioma: widget.idioma,
                            ),
                      ),
                    );
                  },
                  child: Text(widget.idioma.textos["volverAJugar"]!),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {

                    Navigator.pop(context); // cierra el diálogo

                    Navigator.pop(context); // cierra BattleScreen

                    Navigator.pop(context); // cierra TeamSelectionScreen
                  },
                  child: const Text("SALIR"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// =========================// VIDA// =========================

  Widget buildHealthBar(double value) {

    Color color;

    if (value > 0.5) {
      color = Colors.green;
    } else if (value > 0.2) {
      color = Colors.orange;
    } else {
      color = Colors.red;
    }

    return Container(
      height: 8,

      decoration: BoxDecoration(
        color: Colors.grey.shade800,

        borderRadius:
        BorderRadius.circular(20),
      ),

      child: FractionallySizedBox(
        alignment:
        Alignment.centerLeft,

        widthFactor: value,

        child: Container(
          decoration: BoxDecoration(
            color: color,

            borderRadius:
            BorderRadius.circular(
                20),
          ),
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
      const Color(0xFF10151D),

      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding:
              const EdgeInsets.all(18),

              child: Align(
                alignment:
                Alignment.topLeft,

                child: Container(
                  width: 410,

                  padding:
                  const EdgeInsets.all(
                      16),

                  decoration:
                  BoxDecoration(
                    color: const Color(
                        0xFF1A212B),

                    borderRadius:
                    BorderRadius
                        .circular(24),
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [

                      Text(
                        enemy["name"],

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                          height: 12),

                      buildHealthBar(
                          enemyHp),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child:
              Stack(
                children: [

                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/fondos/fondo_combate.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Container(
                    color: Colors.black26,
                  ),

                  Positioned(
                    top: 50,
                    right: 20,

                    child: Image.asset(
                      enemy["mega"] == true
                          ? "assets/sprites/Mega${enemy["name"].replaceFirst("MEGA ", "")}_1.png"
                          : "assets/sprites/${enemy["name"].replaceFirst("MEGA ", "")}_1.png",
                      width: 170,
                      height: 170,
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    bottom: -40,
                    left: -10,

                    child: Image.asset(
                      currentDino["mega"] == true
                          ? "assets/sprites/Mega${currentDino["name"].replaceFirst("MEGA ", "")}_2.png"
                          : "assets/sprites/${currentDino["name"].replaceFirst("MEGA ", "")}_2.png",
                      width: 270,
                      height: 270,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.symmetric(
                  horizontal: 18),

              child: Container(
                padding:
                const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(
                      0xFF1A212B),

                  borderRadius:
                  BorderRadius.circular(
                      24),
                ),

                child: Column(
                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            currentDino["name"],

                            style:
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "${(currentDino["hp"] * 100).toInt()}/100",

                          style:
                          const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    buildHealthBar(
                      currentDino["hp"],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            Padding(
              padding:
              const EdgeInsets.symmetric(
                  horizontal: 20),

              child: Text(
                battleMessage,

                textAlign:
                TextAlign.center,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 14),

            Expanded(

              flex: 1,

              child: Container(

                padding:
                const EdgeInsets.all(18),

                decoration:
                const BoxDecoration(
                  color:
                  Color(0xFF0C1016),

                  borderRadius:
                  BorderRadius.vertical(
                    top:
                    Radius.circular(34),
                  ),
                ),

                child: showDinos

                    ? Column(
                  children: [

                    Expanded(
                      child: ListView.builder(
                        itemCount:
                        team.length + 1,

                        itemBuilder: (context, index) {

                          if (index == team.length) {

                            return Padding(
                              padding: const EdgeInsets.only(top: 16),

                              child: GestureDetector(
                                onTap: () {

                                  setState(() {

                                    showDinos = false;
                                    showAttacks = false;
                                  });
                                },

                                child: Container(
                                  height: 60,

                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,

                                    borderRadius:
                                    BorderRadius.circular(22),
                                  ),

                                  child: Center(
                                    child: Text(
                                      widget.idioma.textos["volver"]!,

                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          final dino = team[index];

                          return GestureDetector(
                            onTap: () => switchDino(dino),

                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 14,
                              ),

                              padding: const EdgeInsets.all(18),

                              decoration: BoxDecoration(
                                color: dino["color"],
                                borderRadius:
                                BorderRadius.circular(20),
                              ),

                              child: Row(
                                children: [

                                  Expanded(
                                    child: Text(
                                      dino["name"],

                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  Text(
                                    "${(dino["hp"] * 100).toInt()} HP",

                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )

                    : showAttacks

                    ? ListView(
                  children: [

                    if (!megaUsed &&
                        currentDino["mega"] != true)

                      GestureDetector(
                        onTap: useMegaDino,

                        child: Container(
                          height: 70,

                          decoration:
                          BoxDecoration(
                            color:
                            Colors.purple,

                            borderRadius:
                            BorderRadius.circular(
                                28),
                          ),

                          child:
                          const Center(
                            child: Text(
                              "MEGADINO",

                              style:
                              TextStyle(
                                color:
                                Colors.white,
                                fontSize:
                                20,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                    if (!megaUsed &&
                        currentDino["mega"] != true)

                      const SizedBox(
                          height: 16),

                    GridView.builder(
                      shrinkWrap: true,

                      physics:
                      const NeverScrollableScrollPhysics(),

                      itemCount:
                      currentDino["attacks"].length,

                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),

                      itemBuilder: (context, index) {

                        final attack =
                        currentDino["attacks"][index];

                        return GestureDetector(
                          onTap: () =>
                              attackEnemy(attack),

                          child: Container(
                            decoration: BoxDecoration(
                              color: attack["color"],

                              borderRadius:
                              BorderRadius.circular(24),
                            ),

                            child: Center(
                              child: Text(
                                widget.idioma.textos[
                                attack["name"]
                                ] ??
                                    attack["name"],

                                textAlign: TextAlign.center,

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {

                        setState(() {

                          showAttacks = false;
                          showDinos = false;
                        });
                      },

                      child: Container(
                        height: 60,

                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,

                          borderRadius:
                          BorderRadius.circular(22),
                        ),

                        child: Center(
                          child: Text(
                            widget.idioma.textos["volver"]!,

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                  ],
                )

                    : Column(
                  children: [

                    GestureDetector(
                      onTap: () {

                        setState(() {

                          showAttacks =
                          true;

                          showDinos =
                          false;
                        });
                      },

                      child: Container(
                        height: 90,

                        decoration:
                        BoxDecoration(
                          color:
                          Colors.redAccent,

                          borderRadius:
                          BorderRadius.circular(
                              28),
                        ),

                        child:
                        Center(
                          child: Text(
                            widget.idioma.textos["luchar"]!,

                            style:
                            const TextStyle(
                              color:
                              Colors.white,
                              fontSize:
                              36,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    Row(
                      children: [

                        Expanded(
                          child:
                          GestureDetector(
                            onTap:
                            useMeat,

                            child:
                            Container(
                              height:
                              80,

                              decoration:
                              BoxDecoration(
                                color:
                                Colors.orange,

                                borderRadius:
                                BorderRadius.circular(
                                    22),
                              ),

                              child:
                              Center(
                                child:
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,

                                  children: [

                                    Text(
                                      widget.idioma.textos["mochila"]!,

                                      style:
                                      TextStyle(
                                        color:
                                        Colors.white,
                                        fontSize:
                                        22,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(
                                        height:
                                        4),

                                    Text(
                                      "🥩 x$meatCount",

                                      style:
                                      const TextStyle(
                                        color:
                                        Colors.white70,
                                        fontSize:
                                        18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                            width: 16),

                        Expanded(
                          child:
                          GestureDetector(
                            onTap:
                                () {

                              setState(() {

                                showDinos =
                                true;

                                showAttacks =
                                false;
                              });
                            },

                            child:
                            Container(
                              height:
                              80,

                              decoration:
                              BoxDecoration(
                                color:
                                Colors.green,

                                borderRadius:
                                BorderRadius.circular(
                                    22),
                              ),

                              child:
                              Center(
                                child:
                                Text(
                                  widget.idioma.textos["dinos"]!,

                                  style:
                                  TextStyle(
                                    color:
                                    Colors.white,
                                    fontSize:
                                    26,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }}