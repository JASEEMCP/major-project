import 'package:app/domain/explorer/explore_data_model/explore_data_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/explore/explore_view.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

final ValueNotifier<bool> _isLoading = ValueNotifier(false);
List<ExploreDataModel> _explore = [];

class CollegeDetailView extends StatefulWidget {
  const CollegeDetailView({super.key});

  @override
  State<CollegeDetailView> createState() => _CollegeDetailViewState();
}

class _CollegeDetailViewState extends State<CollegeDetailView> {
  _fetchExploreData() async {
    try {
      if (_explore.isNotEmpty) return;
      _isLoading.value = true;

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/admin/data-explore/');
      if (response.statusCode == 200) {
        _explore = (response.data as List)
            .map((e) => ExploreDataModel.fromJson(e))
            .toList();
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchExploreData();
  }

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return ValueListenableBuilder(
      valueListenable: _isLoading,
      builder: (context, isLoading, _) {
        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (_explore.isEmpty) {
          return const Center(child: CustomText(txt: 'No data found'));
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(inset.sm),
          child: Container(
            padding: EdgeInsets.all(inset.sm),
            decoration: applyBorderRadius(context),
            child: Column(
              children: [
                const Row(
                  children: [
                    CustomText(
                      txt: 'Info',
                      fontSize: 20,
                    ),
                  ],
                ),
                Gap(inset.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rowTitleText('Club Name', pref.token.value.name ?? 'N/A'),
                    Gap(inset.sm),
                    BuildEventHistory(
                      data: _explore,
                    ),
                  ],
                ),
                ListView.separated(
                  separatorBuilder: (context, index) => Gap(inset.xs),
                  shrinkWrap: true,
                  itemCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return Container(
                      padding: EdgeInsets.all(inset.sm),
                      decoration: applyBorderRadius(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            txt: 'IEDC',
                            color: Colors.green,
                          ),
                          rowTitleText('Authorizer', 'Rahul'),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuildEventHistory extends StatelessWidget {
  const BuildEventHistory({
    super.key,
    required this.data,
  });

  final List<ExploreDataModel> data;

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return ListView.separated(
      separatorBuilder: (context, index) => Gap(inset.xs),
      shrinkWrap: true,
      itemCount: data.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) {
        return Container(
          padding: EdgeInsets.all(inset.sm),
          color: context.theme.indigoLight,
          child: Column(
            spacing: inset.xs,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  Gap(inset.xs),
                  Expanded(
                    child: CustomText(
                      txt: data[index].eventName ?? 'N/A',
                      color: context.theme.indigo,
                      fontSize: 20,
                    ),
                  ),
                  rowTitleText(
                    'Date of Event',
                    data[index].eventPostDate ?? 'N/A',
                  ),
                ],
              ),
              Gap(inset.xs),
              rowTitleText('Fee', 'INR ${data[index].eventFee ?? 'N/A'}'),
              rowTitleText('Slot Count', data[index].eventSlotCount.toString()),
              rowTitleText(
                'Category',
                data[index].category ?? 'N/A',
              ),
              rowTitleText('Credit Score', data[index].credit.toString()),
              rowTitleText(
                'Expiry Date',
                data[index].eventExpiryDate ?? 'N/A',
              ),
              rowTitleText(
                'Description',
                data[index].description ?? 'N/A',
              ),
              Gap(inset.sm),
              ListView.separated(
                itemCount: _explore[index].students?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Gap(inset.xs),
                itemBuilder: (ctx, indexS) {
                  return Container(
                    padding: EdgeInsets.all(inset.sm),
                    decoration: applyBorderRadius(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: inset.xs,
                          children: [
                            CustomText(
                              txt: _explore[index]
                                      .students?[indexS]
                                      .studentName ??
                                  'N/A',
                              color: context.theme.indigo,
                            ),
                            rowTitleText(
                                'Academic Year',
                                _explore[index]
                                        .students?[indexS]
                                        .academicYear ??
                                    'N/A'),
                          ],
                        ),
                        rowTitleText(
                            'Branch',
                            _explore[index].students?[indexS].department ??
                                'N/A'),
                        Row(
                          children: [
                            rowTitleText('Attended', ''),
                            (_explore[index].students?[indexS].isAttended ??
                                    false)
                                ? const Icon(
                                    Icons.verified,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
