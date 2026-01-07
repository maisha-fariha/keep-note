import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_note/controllers/color_controller.dart';
import 'package:keep_note/controllers/notes_controller.dart';
import 'package:keep_note/models/notes_model.dart';
import 'package:keep_note/widgets/keep_tool_text_bar.dart';

import '../controllers/text_style_controller.dart';
import '../widgets/keep_color_bottom_sheet.dart';

class TextNotesScreen extends StatefulWidget {
  final NotesModel? note;
  const TextNotesScreen({super.key, this.note});

  @override
  State<TextNotesScreen> createState() => _TextNotesScreenState();
}


class _TextNotesScreenState extends State<TextNotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final NotesController notesController = Get.find();
  final ColorController colorController = Get.put(ColorController());
  final TextStyleController styleController = Get.find<TextStyleController>();


  Color selectedColor = Colors.white;

  final FocusNode titleFocus = FocusNode();
  final FocusNode noteFocus = FocusNode();

  bool _isTitleFocused = false;
  bool _isNoteFocused = false;



  @override
  void initState() {
    super.initState();

    if(widget.note != null) {
      titleController.text = widget.note!.title;
      noteController.text = widget.note!.content;

      styleController.restoreFromNote(widget.note!);

      colorController.selectedColor.value = Color(widget.note!.color);
    }

    titleFocus.addListener(() {
      setState(() {
        _isTitleFocused = titleFocus.hasFocus;
      });
    });

    noteFocus.addListener(() {
      setState(() {
        _isNoteFocused = noteFocus.hasFocus;
      });
    });
  }


  void _saveAndBack() {
    final style = Get.find<TextStyleController>();
    final note =  NotesModel(
      id: widget.note?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text,
        content: noteController.text,
        color: colorController.selectedColor.value.value,

        bold: style.bold.value,
        italic: style.italic.value,
        underline: style.underline.value,
        heading: style.heading.value.name,
      );

    if(widget.note == null) {
      notesController.addNotes(note);
    }else {
      notesController.updateNote(note);
    }

    style.reset();
    colorController.reset();
    Get.back();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _saveAndBack();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: _saveAndBack,
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Colors.grey.shade200,
              ),
              child: Icon(Icons.push_pin_outlined, size: 25),
            ),
            SizedBox(width: 5),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Colors.grey.shade200,
              ),
              child: Icon(Icons.add_alert_outlined, size: 25),
            ),
            SizedBox(width: 5),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Colors.grey.shade200,
              ),
              child: Icon(Icons.archive_outlined, size: 25),
            ),
          ],
        ),
        body: Obx(
          () => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: colorController.selectedColor.value,
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      maxLines: null,
                      minLines: 1,
                      controller: titleController,
                      focusNode: titleFocus,
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        hintText: _isTitleFocused ? '' : 'Title',
                        labelStyle: TextStyle(fontSize: 24),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      maxLines: null,
                      minLines: 1,
                      controller: noteController,
                      focusNode: noteFocus,
                      style: styleController.textStyle,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: _isNoteFocused ? '' : 'Notes',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Obx(() {
          final style = Get.find<TextStyleController>();

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                if (style.showToolbar.value)
                  KeepToolTextBar(),


                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  color: colorController.selectedColor.value,
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        onPressed: () {},
                        child:  Icon(Icons.add_box_outlined),
                      ),
                      SizedBox(width: 5,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        onPressed: () {
                          KeepColorBottomSheet.show(context);
                        },
                        child:  Icon(Icons.color_lens_outlined),
                      ),
                      SizedBox(width: 5,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        onPressed: () {
                          style.toggleToolbar();
                          FocusScope.of(context).requestFocus(noteFocus);
                        },
                        child:Icon(Icons.text_format),

                      ),
                       Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        onPressed: () {},
                        child:  Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),

      ),
    );
  }
}
