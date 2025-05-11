import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:confetti/confetti.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BirthdayApp());
}

class BirthdayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Color(0xFFF5B5C8),
        colorScheme: ColorScheme.light(
          primary: Color(0xFFF5B5C8),
          secondary: Color(0xFF7EB5DE),
          surface: Color(0xFFFFF6F9),
        ),
      ),
      home: BirthdayWishGenerator(),
    );
  }
}

class BirthdayWishGenerator extends StatefulWidget {
  @override
  _BirthdayWishGeneratorState createState() => _BirthdayWishGeneratorState();
}

class _BirthdayWishGeneratorState extends State<BirthdayWishGenerator> {
  String currentWish = 'Shake your phone for a special birthday wish!';
  double _shakeThreshold = 10.0;
  DateTime _lastShakeTime = DateTime.now();
  Color currentBackgroundColor = Color(0xFFFFF6F9);
  Color currentTextColor = Color(0xFF5D4157);
  bool showLetter = false;

  late ConfettiController _confettiController;
  late ConfettiController _letterConfettiController;
  final List<String> backgroundGradients = [
    'pastel_pink',
    'blue_purple',
    'sunset_orange',
    'mint_green',
    'lavender',
  ];
  String currentGradient = 'pastel_pink';

  final String friendName = "Kelsy ♥";
  final String fullName = "Alina Kelsy Sènami KOUCHICA ♥";

  final List<String> birthdayWishes = [
    "I wish you the happiest birthday ever, because you truly deserve it.♥",

    "I wish you to always feel how deeply loved you are—especially by me.♥",

    "I wish you laughter every single day, even on the hard ones.♥",

    "I wish you mornings full of hope and nights full of peace.♥",

    "I wish you to always believe in yourself like I believe in you.♥",

    "I wish you success in everything your heart is set on.♥",

    "I wish you moments that make your soul dance with joy.♥",

    "I wish you to be surrounded by people who truly see your light.♥",

    "I wish you strength when things feel heavy.♥",

    "I wish you courage to keep chasing your dreams, no matter how big.♥",

    "I wish you little surprises that make you giggle like we used to.♥",

    "I wish you soft days, where you can just breathe and smile.♥",

    "I wish you deep rest when your heart needs it.♥",

    "I wish you to never doubt how amazing you are.♥",

    "I wish you a life that keeps unfolding beautifully, step by step.♥",

    "I wish you travel, discovery, and all the new experiences your soul craves.♥",

    "I wish you peace with your past and full excitement for your future.♥",

    "I wish you a year that opens doors you never even imagined.♥",

    "I wish you to feel proud of how far you’ve come.♥",

    "I wish you days where everything just flows—effortlessly.♥",

    "I wish you more of the kind of love you give so freely.♥",

    "I wish you a heart full of joy, no matter what life throws your way.♥",

    "I wish you everything good, everything kind, everything true.♥",

    "I wish you me—always here, cheering for you, loving you, and proud to call you my best friend for life.♥",
  ];

  final List<String> personalMemories = [
    "Thank for our 5 minutes phone's call, that finally make more than 3 hours.♥",
    "The day you makeup me and we went to a night club.♥",
    "Remember our phone call after we passed our BAC.♥",
    "That time we stayed up all night talking about our dreams and futures...♥",
    "The day we made that pact to always be friends forever, no matter what...♥",
  ];

  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 3));
    _letterConfettiController = ConfettiController(
      duration: Duration(seconds: 5),
    );
    _startListeningToShakes();
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _confettiController.dispose();
    _letterConfettiController.dispose();
    super.dispose();
  }

  void _startListeningToShakes() {
    _accelerometerSubscription = accelerometerEvents.listen((
      AccelerometerEvent event,
    ) {
      double accelerationMagnitude = sqrt(
        event.x * event.x + event.y * event.y + event.z * event.z,
      );
      DateTime now = DateTime.now();

      if (accelerationMagnitude > _shakeThreshold &&
          now.difference(_lastShakeTime).inMilliseconds > 1000) {
        _generateNewWish();
        _lastShakeTime = now;
      }
    });
  }

  void _generateNewWish() {
    setState(() {
      if (Random().nextDouble() < 0.8) {
        currentWish = birthdayWishes[Random().nextInt(birthdayWishes.length)];
      } else {
        currentWish =
            personalMemories[Random().nextInt(personalMemories.length)];
      }

      // Change background gradient
      currentGradient =
          backgroundGradients[Random().nextInt(backgroundGradients.length)];

      // Play confetti animation
      _confettiController.play();
    });
  }

  LinearGradient _getGradient() {
    switch (currentGradient) {
      case 'pastel_pink':
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF5B5C8), Color(0xFFD0E6F2)],
        );
      case 'blue_purple':
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7EB5DE), Color(0xFFBB8FCE)],
        );
      case 'sunset_orange':
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF8C471), Color(0xFFF1948A)],
        );
      case 'mint_green':
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7DCEA0), Color(0xFFA2D9CE)],
        );
      case 'lavender':
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFBB8FCE), Color(0xFFD2B4DE)],
        );
      default:
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF5B5C8), Color(0xFFD0E6F2)],
        );
    }
  }

  void _toggleLetter() {
    setState(() {
      showLetter = !showLetter;
      if (showLetter) {
        _letterConfettiController.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(decoration: BoxDecoration(gradient: _getGradient())),

          // Decorative Elements
          Positioned(
            top: -50,
            right: -50,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.favorite, size: 200, color: Colors.white),
            ),
          ),

          Positioned(
            bottom: -50,
            left: -50,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.cake, size: 200, color: Colors.white),
            ),
          ),

          Positioned(
            top: 40,
            left: 10,
            child: Opacity(
              opacity: 0.2,
              child: Text(
                "${friendName}",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
          ),

          Positioned(
            bottom: 135,
            left: 90,
            child: Opacity(
              opacity: 0.2,
              child: Text(
                "Alina ♥",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
          ),

          Positioned(
            bottom: 25,
            right: 5,
            child: Opacity(
              opacity: 0.2,
              child: Text(
                "Sènami ♥",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Happy Birthday, ${friendName}',

                      style: GoogleFonts.caveat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),

                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Text(
                      '24 wishes for 24 years old.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                      ) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child:
                          !showLetter
                              ? Container(
                                key: ValueKey("wishCard"),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 4),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    Text(
                                      currentWish,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        height: 1.4,
                                        color: Color(0xFF5D4157),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.phone_iphone,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Shake your phone\nto see another wish or memory.',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                              : Container(
                                key: ValueKey("letterCard"),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 4),
                                      blurRadius: 10,
                                    ),
                                  ],
                                  border: Border.all(
                                    color: _getGradient().colors[0].withOpacity(
                                      0.5,
                                    ),
                                    width: 2,
                                  ),
                                ),
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.mail,
                                          size: 24,
                                          color: _getGradient().colors[0],
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'A Special Letter For ${friendName}',
                                          style: GoogleFonts.caveat(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: _getGradient().colors[0],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Container(
                                      height: 180,
                                      child: SingleChildScrollView(
                                        child: Text(
                                          "Dear ${fullName},\n\n"
                                          "It's so amazing to believe that we've been friends for 20 incredible years. Through all of life's ups and downs, you've been my constant, my rock, and my favorite person to laugh with.\n\n"
                                          "I remember when we first met, in primary school who would have thought that would be the start of such an amazing friendship? Since then, we've shared countless memories, adventures, secrets, and dreams.\n\n"
                                          "You've seen me at my worst and still chose to stick around. You've celebrated my successes as if they were your own. When I look back at the most significant moments of my life, you're there in so many of them.\n\n"
                                          "On your birthday, I want you to know how grateful I am for your friendship. You make my life better just by being in it. You inspire me, support me, and make me laugh like no one else can.\n\n"
                                          "Here's to another year of your amazing life and to many more decades of our friendship. May this year bring you all the happiness, success, and love that you deserve.\n\n"
                                          "Happy Birthday, ${friendName}\n\n"
                                          "I love you always,more than white Kinder Bueno, and forever\n"
                                          "Dani xoxo",
                                          style: TextStyle(
                                            fontSize: 16,
                                            height: 1.4,
                                            color: Color(0xFF5D4157),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    ),
                    SizedBox(height: 40),
                    !showLetter
                        ? ElevatedButton(
                          onPressed: _generateNewWish,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: _getGradient().colors[0],
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            'New Birthday Wish',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                        : ElevatedButton(
                          onPressed: _toggleLetter,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: _getGradient().colors[0],
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            'Back to Wishes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ),

          // Floating Action Button for Letter
          Positioned(
            bottom: 30,
            right: 0,
            left: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: _toggleLetter,
                backgroundColor: _getGradient().colors[0],
                elevation: 8,
                child: Icon(
                  showLetter ? Icons.favorite : Icons.mail,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Confetti Controller for wishes
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 1,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
              colors: [
                Colors.pink[100]!,
                Colors.blue[100]!,
                Colors.yellow[100]!,
                Colors.green[100]!,
                Colors.purple[100]!,
              ],
            ),
          ),

          // Confetti Controller for letter
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _letterConfettiController,
              blastDirectionality: BlastDirectionality.explosive,
              maxBlastForce: 7,
              minBlastForce: 3,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.1,
              colors: [
                Colors.red[200]!,
                Colors.pink[200]!,
                Colors.purple[200]!,
                Colors.deepPurple[200]!,
                Colors.indigo[200]!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
