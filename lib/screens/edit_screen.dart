import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, this.note});
  final Note? note;
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);
      _contentController = TextEditingController(text: widget.note!.content);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCE5FF),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 38,
                    height: 40,
                    decoration: BoxDecoration(
                        color:
                            Color.fromARGB(255, 88, 183, 202).withOpacity(.6),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color.fromARGB(135, 0, 25, 85),
                    ),
                  )),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                TextField(
                  controller: _titleController,
                  style: const TextStyle(
                      fontSize: 30, color: Color.fromARGB(135, 0, 25, 85)),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(135, 0, 25, 85),
                      fontSize: 30,
                    ),
                  ),
                ),
                TextField(
                  controller: _contentController,
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(135, 0, 25, 85)),
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type something...',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(135, 0, 25, 85), fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(
              context, [_titleController.text, _contentController.text]);
        },
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 20, 128, 149).withOpacity(.8),
        child: const Icon(
          Icons.save,
          color: Color.fromARGB(255, 250, 228, 190),
        ),
      ),
    );
  }
}
