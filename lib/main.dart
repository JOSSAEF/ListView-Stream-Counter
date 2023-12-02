import 'package:flutter/material.dart';
import 'package:prueba_2/screens/stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List View Dinamico con Counter Stream',
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final _counterStream = CounterStream();

  @override
  void initState() {
    super.initState();
    _counterStream.startCounter();
  }

  @override
  void dispose() {
    _counterStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List View Counter Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder<int>(
              stream: _counterStream.counterStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("Numero: $index"),
                        );
                      },
                    );
                  }
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                return const SizedBox(); // Placeholder widget, you can change it accordingly
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("Stop"),
        onPressed: () {
          // You can add logic to stop the counter here
        },
      ),
    );
  }
}