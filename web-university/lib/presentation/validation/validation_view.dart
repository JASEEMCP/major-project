import 'package:app/domain/explorer/college_list_model/college_list_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/explore/explore_view.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

List<CollegeListModel> _collegeList = [];

final ValueNotifier<bool> _isLoading = ValueNotifier(false);

class CollegeValidation extends StatefulWidget {
  const CollegeValidation({super.key});

  @override
  State<CollegeValidation> createState() => _CollegeValidationState();
}

class _CollegeValidationState extends State<CollegeValidation> {
  Future _fetchColleges() async {
    try {
      if (_collegeList.isNotEmpty) {
        return;
      }
      _isLoading.value = true;
      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}/home/university/unverified-college-list/');
      if (response.statusCode == 200) {
        final data = response.data as List;
        _collegeList = data.map((e) => CollegeListModel.fromJson(e)).toList();
        _isLoading.value = false;
      } else {
        _isLoading.value = false;
      }
    } catch (e) {
      _isLoading.value = false;
    }
  }

  Future _refresh() async {
    try {
      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}/home/university/unverified-college-list/');
      if (response.statusCode == 200) {
        final data = response.data as List;
        _collegeList = data.map((e) => CollegeListModel.fromJson(e)).toList();
        _isLoading.value = true;
        _isLoading.value = false;
      }
    } catch (e) {
      return;
    }
  }

  final ValueNotifier<bool> _isVerifying = ValueNotifier(false);

  _verifyCollege(String collegeId, BuildContext ctx) async {
    try {
      _isVerifying.value = true;
      final response = await dioClient.dio.put(
        '${Env().apiBaseUrl}/home/university/unverified-college-list/',
        data: {
          'college_id': collegeId,
        },
      );
      if (response.statusCode == 200) {
        if (ctx.mounted) {
          ctx.showCustomSnackBar('College verified successfully', Colors.green);
        }
        await _refresh();
        _isVerifying.value = false;
      } else {
        if (ctx.mounted) {
          ctx.showCustomSnackBar(
              response.data['message'] ?? 'An error occurred');
        }
        _isVerifying.value = false;
      }
    } on DioException catch (e) {
      if (ctx.mounted) {
        ctx.showCustomSnackBar(
            e.response?.data['message'] ?? 'An error occurred');
      }
      _isVerifying.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchColleges();
  }
  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_collegeList.isEmpty) {
            return const Center(child: Text('No data found'));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(inset.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  txt: 'Verify Colleges',
                  fontSize: 20,
                ),
                Gap(inset.sm),
                Container(
                  width: double.maxFinite,
                  color: context.theme.indigoLight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.separated(
                        itemCount: _collegeList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Gap(inset.xs),
                        itemBuilder: (ctx, index) {
                          return Container(
                            padding: EdgeInsets.all(inset.sm),
                            decoration: applyBorderRadius(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomText(
                                      txt: _collegeList[index].name ?? ''),
                                ),
                                CustomButton(
                                  width: 80,
                                  name: 'View',
                                  radius: 30,
                                  color: Colors.indigo,
                                  onTap: () {
                                    context.go(
                                      ScreenPath.detail(
                                        _collegeList[index].collegeId ?? '',
                                      ),
                                    );
                                  },
                                ),
                                Gap(inset.sm),
                                ValueListenableBuilder(
                                  valueListenable: _isVerifying,
                                  builder: (context, isVerifying, _) {
                                    return CustomButton(
                                      width: 80,
                                      name:
                                           isVerifying && currentIndex==index ? 'Verifying' : 'Verify',
                                      radius: 30,
                                      color: Colors.green,
                                      onTap: isVerifying && currentIndex==index
                                          ? null
                                          : () {
                                            currentIndex = index;
                                              _verifyCollege(
                                                  _collegeList[index]
                                                          .collegeId ??
                                                      '',
                                                  context);
                                            },
                                    );
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
