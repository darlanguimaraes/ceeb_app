import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/models/node/note_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteListCard extends StatelessWidget {
  final NoteModel note;

  const NoteListCard({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        color: Colors.grey[100],
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          title: Text(
            note.text,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(DateFormat('dd/MM/yyyy').format(note.date)),
          leading: note.complete
              ? const Icon(
                  Icons.check_box,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.amber,
                ),
          trailing: IconButton(
            icon: const Icon(
              Icons.edit,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pushNamed(
              Constants.ROUTE_NOTE_FORM,
              arguments: note,
            ),
          ),
        ),
      ),
    );
  }
}