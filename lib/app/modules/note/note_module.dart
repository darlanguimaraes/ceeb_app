import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/module/ceeb_module.dart';
import 'package:ceeb_app/app/modules/note/form/cubit/note_form_cubit.dart';
import 'package:ceeb_app/app/modules/note/form/note_form_page.dart';
import 'package:ceeb_app/app/modules/note/list/cubit/note_list_cubit.dart';
import 'package:ceeb_app/app/modules/note/list/note_list_page.dart';
import 'package:ceeb_app/app/repositories/note/note_repository.dart';
import 'package:ceeb_app/app/repositories/note/note_repository_impl.dart';
import 'package:ceeb_app/app/services/note/note_service.dart';
import 'package:ceeb_app/app/services/note/note_service_impl.dart';
import 'package:provider/provider.dart';

class NoteModule extends CeebModule {
  NoteModule()
      : super(
          bindings: [
            Provider<NoteRepository>(
              create: (context) =>
                  NoteRepositoryImpl(isarHelper: context.read()),
            ),
            Provider<NoteService>(
              create: (context) =>
                  NoteServiceImpl(noteRepository: context.read()),
            ),
            Provider(create: (context) => NoteListCubit(context.read())),
            Provider(create: (context) => NoteFormCubit(context.read())),
          ],
          router: {
            Constants.ROUTE_NOTE_LIST: (context) => const NoteListPage(),
            Constants.ROUTE_NOTE_FORM: (context) => const NoteFormPage(),
          },
        );
}
