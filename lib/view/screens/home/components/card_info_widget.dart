import 'package:blnk_project/model/blnk_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../view_model/utils/app_assets.dart';
import '../../../../view_model/utils/app_color.dart';

class CardInfoWidget extends StatelessWidget {
  final BlnkForm blnkForm;
  const CardInfoWidget({required this.blnkForm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.darkBlue,
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: AppColors.darkBlue,
              ),
              Expanded(
                child: Text(
                  '${blnkForm.firstName ?? ''} ${blnkForm.lastName ?? ''}',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: AppColors.darkBlue,
              ),
              Expanded(
                child: Text(
                  '${blnkForm.address ?? ''}, ${blnkForm.area ?? ''}',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(
                Icons.phone,
                color: AppColors.darkBlue,
              ),
              Expanded(
                child: Text(
                  blnkForm.landLine ?? '',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(
                Icons.phone_android_rounded,
                color: AppColors.darkBlue,
              ),
              Expanded(
                child: Text(
                  blnkForm.mobile ?? '',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  children: [
                    Container(
                      height: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        'https://drive.google.com/uc?export=view&id=${(blnkForm.frontID ?? '').split('/').last}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Material(
                      color: AppColors.darkBlue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.r),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: InteractiveViewer(
                                    panEnabled: true,
                                    boundaryMargin: const EdgeInsets.all(8),
                                    minScale: 0.5,
                                    maxScale: 3,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: AppAssets.blnkLogo,
                                      placeholderCacheWidth: 10,
                                      placeholderCacheHeight: 10,
                                      placeholderFit: BoxFit.scaleDown,
                                      image:
                                      'https://drive.google.com/uc?export=view&id=${(blnkForm.frontID ?? '').split('/').last}',
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Icon(Icons.zoom_in_rounded, size: 50.sp,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  children: [
                    Container(
                      height: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        'https://drive.google.com/uc?export=view&id=${(blnkForm.backID ?? '').split('/').last}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Material(
                      color: AppColors.darkBlue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.r),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: InteractiveViewer(
                                    panEnabled: true,
                                    boundaryMargin: const EdgeInsets.all(8),
                                    minScale: 0.5,
                                    maxScale: 3,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: AppAssets.blnkLogo,
                                      placeholderCacheWidth: 10,
                                      placeholderCacheHeight: 10,
                                      placeholderFit: BoxFit.scaleDown,
                                      image:
                                      'https://drive.google.com/uc?export=view&id=${(blnkForm.backID ?? '').split('/').last}',
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Icon(Icons.zoom_in_rounded, size: 50.sp,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
