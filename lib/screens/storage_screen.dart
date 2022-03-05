import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:WordWord/models/word.dart';
import 'package:WordWord/boxes.dart';

//import 'package:WordWord/widgets/word_chip.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box<wordtest>>(
        valueListenable: Boxes.getWords().listenable(),
        builder: (context, box, _) {
          final words = box.values.toList().cast<wordtest>();
          return buildContext(words);
        },
      ),
    );
  }

  Widget buildContext(List<wordtest> words) {
    if (words.isEmpty) {
      return const Center(
        child: Text(
          '텅텅 비었다!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 24),
          const Text(
            '다너다너',
            style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 10),
          Align(
              //alignment: Alignment.centerLeft,
              child: Text('총 ${words.length}개의 단어')),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: Boxes.getWords().length,
              itemBuilder: (BuildContext context, int index) {
                var word = words[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.delete,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      setState(() {
                        Boxes.getWords().delete(word.targetCode);
                        //Boxes.getWords().deleteFromDisk();
                      });
                    }
                  },
                  child: buildTransaction(context, word),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTransaction(BuildContext context, wordtest word) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  word.word,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (word.supNo == 0)
                  const SizedBox(width: 1)
                else
                  Text(
                    word.supNo.toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                word.pos,
                style: const TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                word.definition,
                style: const TextStyle(
                  fontSize: 13,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
