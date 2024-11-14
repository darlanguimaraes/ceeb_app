import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/models/note/note_model.dart';
import 'package:ceeb_app/app/modules/note/list/cubit/note_list_cubit.dart';
import 'package:ceeb_app/app/modules/note/widgets/modal_confirm_update_note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteListCard extends StatelessWidget {
  final NoteModel note;
  final NoteListCubit controller;
  final bool status;

  const NoteListCard({
    super.key,
    required this.note,
    required this.controller,
    required this.status,
  });

  Future<void> _showConfirmModal(BuildContext context, String status) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.black26,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            elevation: 10,
            child: ModalConfirmUpdateNote(
              status: status,
            ),
          ),
        );
      },
    );

    if (confirm) {
      note.complete = status == 'Finalizado';
      await controller.update(note);
      await controller.list(!this.status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        _showConfirmModal(context, note.complete ? "Aberto" : "Finalizado");
      },
      child: Card(
        elevation: 5,
        child: Container(
          color: Colors.grey[100],
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            title: Text(
              note.description,
            ),
            subtitle: Text(DateFormat('dd/MM/yyyy').format(note.date)),
            leading: note.complete
                ? const Icon(
                    Icons.check_box,
                    color: Colors.green,
                    size: 30,
                  )
                : const Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.amber,
                    size: 30,
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
      ),
    );
  }
}
