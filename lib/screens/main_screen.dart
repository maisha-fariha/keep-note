import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:keep_note/controllers/main_screen_controller.dart';
import 'package:keep_note/controllers/notes_controller.dart';
import 'package:keep_note/screens/text_notes_screen.dart';
import 'package:keep_note/widgets/keep_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainScreenController controller = Get.put(MainScreenController());
  final NotesController notesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: SearchBar(
                    hintText: 'Search Ke...',
                    elevation: WidgetStateProperty.all(0),
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.view_agenda_outlined),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.swap_vert),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              child: IconButton(onPressed: () {}, icon: Icon(Icons.person)),
            ),
          ),
        ],
      ),
      drawer: KeepDrawer(),
      body: Obx(() {
        if (notesController.notes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.lightbulb_outlined, size: 150),
                Text(
                  'Notes you add appear here',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: notesController.notes.length,
            itemBuilder: (context, index) {
              final note = notesController.notes[index];
              return GestureDetector(
                onTap: () {
                  final note = notesController.notes[index];
                  Get.to(() => TextNotesScreen(note: note));
                },
                child: Card(
                  color: Color(note.color),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(note.color),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (note.title.isNotEmpty)
                          Text(
                            note.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: note.bold
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                        if (note.title.isNotEmpty) SizedBox(height: 6),
                        Text(
                          note.content,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: note.bold
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontStyle: note.italic
                                ? FontStyle.italic
                                : FontStyle.normal,
                            decoration: note.underline
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),

      floatingActionButton: Obx(
        () => SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentGeometry.bottomRight,
            children: [
              if (controller.isFabOpen.value) ...[
                // _fabItem(Icons.mic, 'Audio', 270, ),
                // _fabItem(Icons.image, 'Image', 220),
                // _fabItem(Icons.brush, 'Drawing', 170),
                // _fabItem(Icons.check_box, 'List', 120),
                _fabItem(
                  Icons.text_fields,
                  'Text',
                  70,
                  () => Get.to(() => TextNotesScreen()),
                ),
              ],
              Padding(
                padding: EdgeInsets.all(16),
                child: FloatingActionButton(
                  backgroundColor: Colors.blue.shade800,
                  onPressed: () {
                    controller.toggleFab();
                  },
                  child: Icon(
                    controller.isFabOpen.value ? Icons.close : Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fabItem(
    IconData icon,
    String text,
    double bottom,
    VoidCallback onPressed,
  ) {
    return Positioned(
      right: 16,
      bottom: bottom,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFC5F1F5),
          shape: StadiumBorder(),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.blue.shade800),
        label: Text(text, style: TextStyle(color: Colors.blue.shade800)),
      ),
    );
  }
}
