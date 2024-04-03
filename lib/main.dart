import 'package:flutter/material.dart';

int main() {
  runApp(const MyApp());
  return 1;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

@immutable
class Person {
  final String name;
  final int age;
  final String image;

  const Person({required this.name, required this.age, required this.image});
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black12),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Person> person = [
      const Person(name: "Titan MB", age: 21, image: '🥷'),
      const Person(name: "Peter Parker", age: 24, image: '🕷️'),
      const Person(name: "Tony Stark", age: 46, image: '🦸'),
    ];

    return Scaffold(
      backgroundColor: const Color.fromRGBO(33, 33, 33, 3),
      appBar: AppBar(
        title: const Text(
          "People",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black26,
      ),
      body: Column(
        children: person
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SecondScreen(person: e)));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                      side: BorderSide(color: Colors.white.withOpacity(0.3))),
                  title: Text(
                    e.name,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                  subtitle: Text(
                    "${e.age}",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 15),
                  ),
                  leading: Hero(
                    tag: e.name,
                    child: CircleAvatar(
                      maxRadius: 30,
                      child: Text(
                        e.image,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final Person person;

  const SecondScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(33, 33, 33, 3),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 40,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.black26,
        title: Container(
          margin: const EdgeInsets.only(right: 60),
          width: double.infinity,
          child: Hero(
            tag: person.name,
            flightShuttleBuilder: (
              context,
              animation,
              flightDirection,
              fromHeroContext,
              toHeroContext,
            ) {
              switch (flightDirection) {
                case HeroFlightDirection.push:
                  return Material(
                    color: Colors.transparent,
                    child: ScaleTransition(
                      scale: animation.drive(Tween<double>(begin: 3.0, end: 1.0)
                          .chain(CurveTween(curve: Curves.fastOutSlowIn))),
                      child: toHeroContext.widget,
                    ),
                  );
                case HeroFlightDirection.pop:
                  return Material(
                    color: Colors.transparent,
                    child: fromHeroContext.widget,
                  );
              }
            },
            child: CircleAvatar(
              maxRadius: 40,
              child: Text(
                person.image,
                style: const TextStyle(fontSize: 60),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              person.name,
              style: const TextStyle(color: Colors.white, fontSize: 40),
            ),
            const SizedBox(
              height: 30,
            ),
            Text("${person.age}",
                style: const TextStyle(color: Colors.white, fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
