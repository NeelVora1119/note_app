import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:note_app/constants/colors.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> filteredNotes = [];
  bool sorted = false;
  @override
  void initState() {
    super.initState();
    filteredNotes = sampleNotes;
  }

  List<Note> sortNotesByModifierTime(List<Note> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }
    sorted = !sorted;
    return notes;
  }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredNotes = sampleNotes
          .where((note) =>
              note.content.toLowerCase().contains(searchText.toLowerCase()) ||
              note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void deleteNote(int index) {
    setState(() {
      Note note = filteredNotes[index];
      sampleNotes.remove(note);
      filteredNotes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 149, 255),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 255, 231, 159),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        filteredNotes = sortNotesByModifierTime(filteredNotes);
                      });
                    },
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 95, 95, 184)
                              .withOpacity(.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.sort,
                        color: Color.fromARGB(255, 255, 231, 159),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                onSearchTextChanged(value);
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search",
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 255, 231, 159)),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 255, 231, 159),
                ),
                fillColor: const Color.fromARGB(255, 95, 95, 184),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent)),
              ),
            ),
            AnimationLimiter(
              child: Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 30),
                  itemCount: filteredNotes.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 1575),
                      child: SlideAnimation(
                        verticalOffset: 5.0,
                        child: FadeInAnimation(
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 20),
                            color: getRandomColor(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditScreen(
                                              note: filteredNotes[index]),
                                    ),
                                  );
                                  if (result != null) {
                                    setState(() {
                                      int originalIndex = sampleNotes
                                          .indexOf(filteredNotes[index]);
                                      sampleNotes[originalIndex] = Note(
                                          id: sampleNotes[originalIndex].id,
                                          title: result[0],
                                          content: result[1],
                                          modifiedTime: DateTime.now());
                                      filteredNotes[index] = Note(
                                          id: sampleNotes[index].id,
                                          title: result[0],
                                          content: result[1],
                                          modifiedTime: DateTime.now());
                                      ;
                                    });
                                  }
                                },
                                title: RichText(
                                  maxLines: 3,
                                  overflow: TextOverflow.fade,
                                  text: TextSpan(
                                      text: '${filteredNotes[index].title}\n',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          height: 1.5),
                                      children: [
                                        TextSpan(
                                          text: filteredNotes[index].content,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              height: 1.5),
                                        )
                                      ]),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text(
                                    'Edited: ${DateFormat('EEE MMM d,yyyy h:mm a').format(filteredNotes[index].modifiedTime)}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () async {
                                    final result = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                Colors.grey.shade900,
                                            icon: const Icon(
                                              Icons.info,
                                              color: Colors.grey,
                                            ),
                                            title: const Text(
                                              'Do you want to Delete?',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, true);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green.shade400,
                                                  ),
                                                  child: const SizedBox(
                                                    width: 60,
                                                    child: Text(
                                                      'Yes',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, false);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.red.shade400,
                                                  ),
                                                  child: const SizedBox(
                                                    width: 60,
                                                    child: Text(
                                                      'No',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                    if (result) deleteNote(index);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const EditScreen(),
            ),
          );
          if (result != null) {
            setState(() {
              sampleNotes.add(Note(
                  id: sampleNotes.length,
                  title: result[0],
                  content: result[1],
                  modifiedTime: DateTime.now()));
              filteredNotes = sampleNotes;
            });
          }
        },
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 95, 95, 184),
        child: const Icon(
          Icons.add,
          size: 38,
          color: Color.fromARGB(255, 255, 216, 148),
        ),
      ),
    );
  }
}
