import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/view/presentations/Searching_Screen/pics_screen.dart';
import 'package:graduation/view/shared/component/helperfunctions.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../shared/component/components.dart';
import '../../../shared/component/models.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  bool value = true;

  File? img;

  //used for the second searching screen
  List<Widget> personFields = [];
  List<Person> person = [];
  bool showUndoButton = false;

  final List<String> countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    // ...and so on
  ];
  void sumbitCountery(item, TextEditingController controller) {
    controller.text = item;
    emit(ChangeCountery());
  }

  void changeValues(val) {
    value = val;
    emit(ChangeWays());
  }

  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      emit(ChangeDate());
    }
  }

  void addMorePerson() {
    personFields.add(buildPersonFields());
    if (personFields.length > 1) {
      showUndoButton = true;
    }
    emit(AddPersonField());
  }

  void removePerson() {
    personFields.removeLast();
    if (personFields.length < 2) {
      showUndoButton = false;
    }
    emit(RemovePersonField());
  }

  void p(BuildContext context) {
    for (var widget in personFields) {
      final formKey = widget.key as GlobalKey<FormState>;
      if (formKey.currentState!.validate()) {
        nextScreen(context, const PicScreen());
      } else {
        print("in Vaild ");
      }
    }
  }

  pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      } else {
        //here we save the path of the image ;
        final tempImage = File(image.path);
        img = tempImage;
        emit(ImageCameraSuccessful());
      }
    } on PlatformException catch (e) {
      emit(ImageCameraError(e.toString()));
    }
  }
}
