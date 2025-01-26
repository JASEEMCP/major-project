import 'package:app/domain/explorer/college_list_model/college_list_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

List<CollegeListModel> _collegeList = [];

final ValueNotifier<bool> _isLoading = ValueNotifier(false);

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  Future _fetchColleges() async {
    try {
      if (_collegeList.isNotEmpty) {
        return;
      }
      _isLoading.value = true;
      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}/home/university/college-list/');
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

  @override
  void initState() {
    super.initState();
    _fetchColleges();
  }

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
                  txt: 'Colleges',
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
                                CustomText(txt: _collegeList[index].name ?? ''),
                                CustomButton(
                                  width: 80,
                                  name: 'View',
                                  radius: 30,
                                  onTap: () {
                                    context.go(ScreenPath.detail(
                                        _collegeList[index].collegeId ??
                                            'id88-78'));
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

BoxDecoration applyBorderRadius(BuildContext context) {
  return BoxDecoration(
    color: context.theme.kWhite,
    borderRadius: BorderRadius.circular(10),
  );
}
