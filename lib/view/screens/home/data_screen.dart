import 'package:blnk_project/view_model/cubit/blnk_cubit/blnk_cubit.dart';
import 'package:blnk_project/view_model/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../view_model/cubit/blnk_cubit/blnk_state.dart';
import 'components/card_info_widget.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlnkCubit.get(context)..getData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkBlue,
          centerTitle: false,
          title: Text(
            'Candaties',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<BlnkCubit, BlnkState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = BlnkCubit.get(context);
              return ListView.separated(
                padding: EdgeInsets.all(12.sp),
                itemBuilder: (context, index) {
                  return CardInfoWidget(blnkForm: cubit.data[index],);
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
                itemCount: cubit.data.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
