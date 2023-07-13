import 'dart:convert';
import 'dart:io';
import 'package:blnk_project/view/components/widgets/elevated_button_custom.dart';
import 'package:blnk_project/view/components/widgets/text_form_field_custom.dart';
import 'package:blnk_project/view_model/cubit/blnk_cubit/blnk_cubit.dart';
import 'package:blnk_project/view_model/utils/app_color.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../view_model/cubit/blnk_cubit/blnk_state.dart';
import '../../components/toast_message/toast_message.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlnkCubit, BlnkState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlnkCubit.get(context);
        return Scaffold(
          key: cubit.scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: AppColors.darkBlue,
            title: Text(
              'Blnk Form',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: cubit.formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormFieldCustom(
                          controller: cubit.firstNameController,
                          validate: (value) {
                            if ((value ?? '').trim().isEmpty) {
                              return 'Please, Enter a Valid First Name';
                            }
                            return null;
                          },
                          label: 'First Name',
                          autoValidate: true,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormFieldCustom(
                          controller: cubit.lastNameController,
                          validate: (value) {
                            if ((value ?? '').trim().isEmpty) {
                              return 'Please, Enter a Valid Last Name';
                            }
                            return null;
                          },
                          label: 'Last Name',
                          autoValidate: true,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormFieldCustom(
                          controller: cubit.addressController,
                          validate: (value) {
                            if ((value ?? '').trim().isEmpty) {
                              return 'Please, Enter a Valid Address';
                            }
                            return null;
                          },
                          label: 'Address',
                          autoValidate: true,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            // title: Text('Search'),
                            showSearchBox: true,
                            showSelectedItems: true,
                            searchDelay: const Duration(milliseconds: 300),
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                hintText: 'Search on Area...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: AppColors.darkBlue,
                                    width: 1.w,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: AppColors.darkBlue, width: 2.w),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.grey,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.h,
                                  horizontal: 16.w,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: AppColors.darkBlue,
                                    width: 2.w,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: AppColors.red,
                                    width: 1.5.w,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          items: cubit.areas,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                labelText: "Area",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: AppColors.darkBlue, width: 2.w),
                                ),
                                labelStyle: const TextStyle(
                                  color: AppColors.grey,
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.grey,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.h,
                                  horizontal: 16.w,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: AppColors.darkBlue,
                                    width: 2.w,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: AppColors.red,
                                    width: 1.5.w,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.red,
                                  ),
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: AppColors.darkBlue,
                                )),
                          ),
                          onChanged: (value) {
                            if ((value ?? '').trim().isNotEmpty) {
                              cubit.areaController.text = value ?? '';
                            }
                          },
                          validator: (String? value) {
                            if ((value ?? '').trim().isEmpty) {
                              return 'Please, Choose Your Area';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormFieldCustom(
                          controller: cubit.landlineController,
                          validate: (value) {
                            if ((value ?? '').trim().isEmpty) {
                              return 'Please, Enter a Valid Landline';
                            }
                            return null;
                          },
                          label: 'Landline',
                          autoValidate: true,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormFieldCustom(
                          controller: cubit.mobileController,
                          validate: (value) {
                            if ((value ?? '').trim().length != 11) {
                              return 'Please, Enter 11 Digit Mobile Number';
                            }
                            return null;
                          },
                          label: 'Mobile Number',
                          autoValidate: true,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Front ID',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.darkBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Material(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: InkWell(
                            onTap: () async {
                              cubit.frontImagePath = '';
                              cubit.frontBase64Image = '';
                              var androidInfo;
                              if (Platform.isAndroid) {
                                androidInfo = await DeviceInfoPlugin().androidInfo;
                                late final Map<Permission, PermissionStatus> statuses;

                                if (androidInfo.version.sdkInt <= 32) {
                                  statuses = await [
                                    Permission.storage,
                                  ].request();
                                } else {
                                  statuses = await [
                                    Permission.storage,
                                  ].request();
                                }
                                var allAccepted = true;
                                statuses.forEach((permission, status) {
                                  if (status != PermissionStatus.granted) {
                                    allAccepted = false;
                                  }
                                });
                              }

                              final status = await Permission.storage.request();
                              if (status == PermissionStatus.granted || androidInfo.version.sdkInt > 32) {
                                cubit.uploadFrontIdImage();
                              } else {
                                showToast(
                                  message: 'PLease, Check your Permissions',
                                  color: AppColors.red,
                                );
                                await Permission.storage.request();
                                openAppSettings();
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 150.h,
                              padding: EdgeInsets.all(8.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: cubit.frontIdError ? AppColors.red : AppColors.darkBlue,
                                  width: 2.w,
                                ),
                              ),
                              child: cubit.frontImagePath.isEmpty
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/photo.png',
                                          height: 50.h,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          'Add Your Front ID',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        // Icon(Icons.image, size: 50.w,)
                                      ],
                                    )
                                  : Image.memory(
                                      const Base64Decoder().convert(cubit.frontBase64Image),
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.error_outline_rounded,
                                          color: AppColors.red,
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Back ID',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.darkBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Material(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: InkWell(
                            onTap: () async {
                              cubit.backImagePath = '';
                              cubit.backBase64Image = '';
                              var androidInfo;
                              if (Platform.isAndroid) {
                                androidInfo = await DeviceInfoPlugin().androidInfo;
                                late final Map<Permission, PermissionStatus> statuses;

                                if (androidInfo.version.sdkInt <= 32) {
                                  statuses = await [
                                    Permission.storage,
                                  ].request();
                                } else {
                                  statuses = await [
                                    Permission.storage,
                                  ].request();
                                }
                                var allAccepted = true;
                                statuses.forEach((permission, status) {
                                  if (status != PermissionStatus.granted) {
                                    allAccepted = false;
                                  }
                                });
                              }

                              final status = await Permission.storage.request();
                              if (status == PermissionStatus.granted || androidInfo.version.sdkInt > 32) {
                                cubit.uploadBackIdImage();
                              } else {
                                showToast(
                                  message: 'PLease, Check your Permissions',
                                  color: AppColors.red,
                                );
                                await Permission.storage.request();
                                openAppSettings();
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 150.h,
                              padding: EdgeInsets.all(8.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: cubit.backIdError ? AppColors.red : AppColors.darkBlue,
                                  width: 2.w,
                                ),
                              ),
                              child: cubit.backImagePath.isEmpty
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/photo.png',
                                          height: 50.h,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          'Add Your Back ID',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        // Icon(Icons.image, size: 50.w,)
                                      ],
                                    )
                                  : Image.memory(
                                      const Base64Decoder().convert(cubit.backBase64Image),
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.error_outline_rounded,
                                          color: AppColors.red,
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 50.h,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButtonCustom(
                    onPressed: cubit.submitLoading
                        ? (){}
                        : () {
                            cubit.submitForm();
                          },
                    text: 'Submit',
                    widget: cubit.submitLoading
                        ? const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.white,
                            ),
                          )
                        : const Text('Submit'),
                    borderColor: Colors.transparent,
                    colors: AppColors.darkBlue,
                  ),
                ),
                SizedBox(height: 10.h,),
              ],
            ),
          ),
        );
      },
    );
  }
}