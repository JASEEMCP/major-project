import 'package:app/presentation/explore/explore_view.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class CollegeDetailView extends StatelessWidget {
  const CollegeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
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
                  txt: 'College Name',
                  fontSize: 20,
                ),
              ],
            ),
            Gap(inset.sm),
            Column(
              children: [
                rowTitleText('Name', 'Content Name'),
                rowTitleText('Name', 'Content Name'),
                rowTitleText('Name', 'Content Name'),
                Gap(inset.sm),
                const BuildEventHistory(),
                Gap(inset.sm),
                ListView.separated(
                    separatorBuilder: (context, index) => Gap(inset.xs),
                    shrinkWrap: true,
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return Container(
                        padding: EdgeInsets.all(inset.sm),
                        color: context.theme.indigoLight,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.book_outlined),
                                const CustomText(
                                  txt: 'Computer Science',
                                  color: Colors.green,
                                ),
                                const Spacer(),
                                rowTitleText('Date of Event', '01/11/2001'),
                              ],
                            ),
                            Gap(inset.xs),
                            rowTitleText('Short-Name', 'CSE'),
                            rowTitleText('Strength', '100'),
                            Gap(inset.xs),
                            ListView.separated(
                              separatorBuilder: (context, index) =>
                                  Gap(inset.xs),
                              shrinkWrap: true,
                              itemCount: 3,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return Container(
                                  padding: EdgeInsets.all(inset.sm),
                                  decoration: applyBorderRadius(context),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      rowTitleText('Student Name', 'Rahul'),
                                      rowTitleText(
                                          'Academic  Year', '2021-2025'),
                                      rowTitleText('Credit Earned', '40'),
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BuildEventHistory extends StatelessWidget {
  const BuildEventHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return ListView.separated(
      separatorBuilder: (context, index) => Gap(inset.xs),
      shrinkWrap: true,
      itemCount: 2,
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
                  const CustomText(
                    txt: 'Title',
                  ),
                  const Spacer(),
                  rowTitleText('Date of Event', '01/11/2001'),
                ],
              ),
              Gap(inset.xs),
              rowTitleText('Name', 'Content Name'),
              rowTitleText('Name', 'Content Name'),
              rowTitleText('Name', 'Content Name'),
            ],
          ),
        );
      },
    );
  }
}
