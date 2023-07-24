import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:blnk_project/view/components/toast_message/toast_message.dart';
import 'package:blnk_project/view_model/data/network/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../model/blnk_form.dart';
import 'blnk_state.dart';

class BlnkCubit extends Cubit<BlnkState> {
  BlnkCubit() : super(BlnkInitial());

  static BlnkCubit get(context) => BlocProvider.of<BlnkCubit>(context);

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // TextFormField Controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landlineController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  BlnkForm feedbackForm = BlnkForm();
  bool frontIdError = !true;
  bool backIdError = !true;

  // Method to Submit Blnk Form and save it in Google Sheets
  void submitForm() {
    checkFrontId();
    checkBackId();
    if (formKey.currentState!.validate() && !frontIdError && !backIdError) {
      feedbackForm = BlnkForm(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        area: areaController.text,
        address: addressController.text,
        landLine: landlineController.text,
        mobile: mobileController.text,
        frontID: frontBase64Image,
        backID: backBase64Image,
      );

      sendRequest();
    }
  }

  void checkFrontId() {
    if (frontBase64Image.isEmpty) {
      frontIdError = true;
      return;
    } else {
      frontIdError = false;
    }
    emit(CheckIconsState());
  }

  void checkBackId() {
    if (backBase64Image.isEmpty) {
      backIdError = true;
      return;
    } else {
      backIdError = false;
    }
    emit(CheckIconsState());
  }

  // final ImagePicker frontPicker = ImagePicker();

  String frontBase64Image = '';
  String backBase64Image = '';

  String frontImagePath = '';
  String backImagePath = '';

  bool submitLoading = false;

  Future<void> sendRequest() async {
    emit(SubmitFormLoadingState());
    submitLoading = true;
    await DioHelper.postData(url: '', data: feedbackForm.toJson()).then((value) {
      submitLoading = false;
      log(value.data);
      showToast(message: 'Submitted Successfully');

      firstNameController.clear();
      lastNameController.clear();
      addressController.clear();
      areaController.clear();
      landlineController.clear();
      mobileController.clear();
      frontIdError = !true;
      frontBase64Image = '';
      frontImagePath = '';
      backIdError = !true;
      backBase64Image = '';
      backImagePath = '';

      emit(SubmitFormSuccessState());
    }).catchError((onError) {
      submitLoading = false;
      log(onError.toString());
      if (onError is DioException) {
        if (onError.response?.statusCode == 302) {
          showToast(
            message: 'Submitted Successfully',
          );
        } else {
          showToast(message: 'There\'s an Error Occured');
        }
      }
      emit(SubmitFormErrorState());
    });
  }

  uploadFrontIdImage() async {
    emit(UploadImageLoadingState());
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted = await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      emit(UploadImageErrorState());
      return;
    }

    frontImagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      bool success = await EdgeDetection.detectEdge(
        frontImagePath,
        canUseGallery: true,
        androidScanTitle: 'Scanning',
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      if (success) {
        print(frontImagePath);
        final bytes = File(frontImagePath).readAsBytesSync();
        frontBase64Image = base64Encode(bytes);
        emit(UploadImageSuccessState());
      }
    } catch (e) {
      print(e);
      emit(UploadImageErrorState());
    }
    checkFrontId();
  }

  uploadBackIdImage() async {
    emit(UploadImageLoadingState());
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted = await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      emit(UploadImageErrorState());
      return;
    }

    backImagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      bool success = await EdgeDetection.detectEdge(
        backImagePath,
        canUseGallery: true,
        androidScanTitle: 'Scanning',
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      if (success) {
        print(backImagePath);
        final bytes = File(backImagePath).readAsBytesSync();
        backBase64Image = base64Encode(bytes);
        emit(UploadImageSuccessState());
      }
    } catch (e) {
      print(e);
      emit(UploadImageErrorState());
    }
    checkBackId();
  }

  List<String> areas = [];
  Future<void> getAreas() async {
    areas = [];
    emit(GetAreasLoadingState());
    await DioHelper.getData(
      url: '',
      queryParameters: {
        'data': 'areas',
      },
    ).then((value) {
      print(value.data.runtimeType);
      value.data.forEach((element){
        areas.add('$element');
      });
      print(areas);
      emit(GetAreasSuccessState());
    });
  }

  List<BlnkForm> data = [];

  Future<void> getData() async {
    data = [];
    emit(GetAreasLoadingState());
    await DioHelper.getData(
      url: '',
      queryParameters: {
        'data': 'data',
      },
    ).then((value) {
      print(value.data);
      value.data.forEach((element){
        data.add(BlnkForm.fromJson(element));
      });
      data = data.reversed.toList();
      print(data);
      emit(GetAreasSuccessState());
    });
  }
}
