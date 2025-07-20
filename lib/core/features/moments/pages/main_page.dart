import 'package:flutter/material.dart';
import 'package:happy_app/core/features/moments/pages/add_moment.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B1B1B),
      appBar: AppBar(title: Center(child: const Text('My moments', style: TextStyle(color: Colors.white))),
        backgroundColor: Color(0xff1B1B1B),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color:  Color(0xff2B2B2B), // Dark grey background for the box
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '“',
                    style: TextStyle(
                      color: Colors.red.shade700, // Red for the quote marks
                      fontSize: 60,
                      height: 0.7, // Adjust line height to align properly
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'The brightest moments are found in simple things: a smile, morning light, a warm cup of tea',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '”',
                    style: TextStyle(
                      color: Colors.red.shade700, // Red for the quote marks
                      fontSize: 60,
                      height: 0.7, // Adjust line height to align properly
                    ),
                  ),
                ],
              ),
            ),
            Text('Moments', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
            Column(
              children: [
                Image.asset(
                  'assets/images/camera.png', // Replace with your image path
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                Text(
                  'Take the Challenge',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Set a goal to take 100 photos of things/ moments that bring you joy, over the course of a year.',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffC9C9C9)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMomentPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB71C1C), // Deep red color
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Add the first moment',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
