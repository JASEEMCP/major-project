import 'package:app/domain/college_detail_model/college_detail_model.dart';
import 'package:app/domain/college_detail_model/event_list.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/explore/explore_view.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class CollegeDetailView extends StatefulWidget {
  const CollegeDetailView({super.key, required this.id});

  final String id;

  @override
  State<CollegeDetailView> createState() => _CollegeDetailViewState();
}

class _CollegeDetailViewState extends State<CollegeDetailView> {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  CollegeDetailModel? _collegeDetail;

  Future _fetchCollegeDetail(String id) async {
    try {
      _isLoading.value = true;
      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}/home/university/college-detail/$id/');
      if (response.statusCode == 200) {
        _collegeDetail = CollegeDetailModel.fromJson(response.data);
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
    _fetchCollegeDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;

    return ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, bool isLoading, _) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_collegeDetail == null) {
            return const Center(
              child: CustomText(
                txt: 'No Data Found',
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(inset.sm),
            child: Container(
              padding: EdgeInsets.all(inset.sm),
              decoration: applyBorderRadius(context),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomCircleBtn(
                        onTap: () {
                          context.pop();
                        },
                      ),
                      Gap(inset.sm),
                      CustomText(
                        txt: _collegeDetail?.name ?? 'N/A',
                        color: context.theme.indigo,
                        fontSize: 20,
                      ),
                    ],
                  ),
                  Gap(inset.sm),
                  Column(
                    spacing: inset.xs,
                    children: [
                      
                      rowTitleText(
                          'Short Name', _collegeDetail?.shortName ?? 'N/A'),
                      rowTitleText('Address', _collegeDetail?.address ?? 'N/A'),
                      rowTitleText('Principle Name',
                          _collegeDetail?.principleName ?? 'N/A'),
                      rowTitleText(
                          'Phone Number', _collegeDetail?.phoneNo ?? 'N/A'),
                      rowTitleText('Email', _collegeDetail?.email ?? 'N/A'),
                      rowTitleText('Website', _collegeDetail?.website ?? 'N/A'),
                      Gap(inset.sm),
                      BuildEventHistory(
                        eventList: _collegeDetail?.eventList ?? [],
                      ),
                      Gap(inset.sm),
                      ListView.separated(
                          itemCount: _collegeDetail?.department?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => Gap(inset.xs),
                          itemBuilder: (context, indexX) {
                            return Container(
                              padding: EdgeInsets.all(inset.sm),
                              color: context.theme.indigoLight,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.book_outlined),
                                      CustomText(
                                        txt: _collegeDetail
                                                ?.department?[indexX].name ??
                                            'N/A',
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  Gap(inset.xs),
                                  rowTitleText(
                                      'Short-Name',
                                      _collegeDetail
                                              ?.department?[indexX].shortName ??
                                          'N/A'),
                                  rowTitleText(
                                      'Strength',
                                      _collegeDetail
                                              ?.department?[indexX].strength
                                              .toString() ??
                                          'N/A'),
                                  Gap(inset.xs),
                                  ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Gap(inset.xs),
                                    shrinkWrap: true,
                                    itemCount: _collegeDetail
                                            ?.department?[indexX]
                                            .studentList
                                            ?.length ??
                                        0,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (ctx, index) {
                                      return Container(
                                        padding: EdgeInsets.all(inset.sm),
                                        decoration: applyBorderRadius(context),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            rowTitleText(
                                                'Student Name',
                                                _collegeDetail
                                                        ?.department?[indexX]
                                                        .studentList?[index]
                                                        .name ??
                                                    'N/A'),
                                            rowTitleText(
                                                'Academic  Year',
                                                _collegeDetail
                                                        ?.department?[indexX]
                                                        .studentList?[index]
                                                        .academicYear ??
                                                    'N/A'),
                                            rowTitleText(
                                                'Credit Earned',
                                                _collegeDetail
                                                        ?.department?[indexX]
                                                        .studentList?[index]
                                                        .creditEarned
                                                        .toString() ??
                                                    'N/A'),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                      Gap(inset.sm),
                      Container(
                        padding: EdgeInsets.all(inset.sm),
                        color: context.theme.indigoLight,
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.add_box),
                                CustomText(
                                  txt: 'Clubs',
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            Gap(inset.sm),
                            ListView.separated(
                              separatorBuilder: (context, index) =>
                                  Gap(inset.xs),
                              shrinkWrap: true,
                              itemCount: _collegeDetail?.clubList?.length ?? 0,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return Container(
                                  padding: EdgeInsets.all(inset.sm),
                                  decoration: applyBorderRadius(context),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        txt: _collegeDetail?.clubList?[index]
                                                .authorityName ??
                                            'N/A',
                                        color: Colors.green,
                                      ),
                                      rowTitleText(
                                          'Authorizer',
                                          _collegeDetail?.clubList?[index]
                                                  .authorName ??
                                              'N/A'),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class BuildEventHistory extends StatelessWidget {
  const BuildEventHistory({
    super.key,
    required this.eventList,
  });

  final List<EventList> eventList;

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return ListView.separated(
      separatorBuilder: (context, index) => Gap(inset.xs),
      shrinkWrap: true,
      itemCount: eventList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) {
        return Container(
          padding: EdgeInsets.all(inset.sm),
          color: context.theme.indigoLight,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  CustomText(
                    txt: eventList[index].eventName ?? 'N/A',
                  ),
                  const Spacer(),
                  rowTitleText('Date of Event', eventList[index].date ?? 'N/A'),
                ],
              ),
              Gap(inset.xs),
              rowTitleText('Category', eventList[index].categoryName ?? 'N/A'),
              rowTitleText('Authority', eventList[index].authority ?? 'N/A'),
              rowTitleText('Event Fee', eventList[index].eventFee.toString()),
            ],
          ),
        );
      },
    );
  }
}
