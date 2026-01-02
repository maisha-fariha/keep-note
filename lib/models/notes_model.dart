

class NotesModel {
  final String id;
  final String title;
  final String content;
  final int color;

  final bool bold;
  final bool italic;
  final bool underline;
  final String heading;


  NotesModel({
    required this.id,
    required this.title,
    required this.content,
    int? color,
    required this.bold,
    required this.italic,
    required this.underline,
    required this.heading,
  }) : color = color ?? 0xFFFFFFFF;

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title': title,
      'content': content,
      'color': color,
      'bold': bold ? 1 : 0,
      'italic': italic ? 1 : 0,
      'underline': underline ? 1 : 0,
      'heading': heading,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      color: map['color'] ?? 0xFFFFFFFF,
      bold: (map['bold'] ?? 0) == 1,
      italic: (map['italic'] ?? 0) == 1,
      underline: (map['underline'] ?? 0) == 1,
      heading: map['heading'] ?? 'normal',
    );
  }
}
