import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_encrypt_app/encrypt_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encrypt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Encrypt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String textValue = 'Welcome@123';

  @override
  void initState() {
    super.initState();
    _controller.text = textValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  label: Text("non-prod-encrypted-text-field"),
                ),
                onChanged: (value) {
                  setState(() {
                    textValue = value;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textValue.isNotEmpty ? AESEncryption.encrypt(textValue) : "",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                IconButton(
                    onPressed: () async {
                      final String textToCopy =
                          AESEncryption.encrypt(textValue);
                      if (textToCopy.isNotEmpty) {
                        try {
                          await Clipboard.setData(
                              ClipboardData(text: textToCopy));
                        } catch (e) {
                          debugPrint("Not encrypted");
                        }
                      }
                    },
                    icon: const Icon(Icons.copy)),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  label: Text("prod-encrypted-text-field"),
                ),
                onChanged: (value) {
                  setState(() {
                    textValue = value;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textValue.isNotEmpty
                      ? AESEncryption.encrypt(textValue, isProd: true)
                      : "",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                IconButton(
                    onPressed: () async {
                      final String textToCopy =
                          AESEncryption.encrypt(textValue, isProd: true);
                      if (textToCopy.isNotEmpty) {
                        try {
                          await Clipboard.setData(
                              ClipboardData(text: textToCopy));
                        } catch (e) {
                          debugPrint("Not encrypted");
                        }
                      }
                    },
                    icon: const Icon(Icons.copy)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
