import 'package:app/domain/explorer/explorer_model/club.dart';
import 'package:app/domain/explorer/explorer_model/explorer_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/explore/explore_view.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

final ValueNotifier<bool> _isLoading = ValueNotifier(false);
ExplorerModel? _explore;

class CollegeDetailView extends StatefulWidget {
  const CollegeDetailView({super.key});

  @override
  State<CollegeDetailView> createState() => _CollegeDetailViewState();
}

class _CollegeDetailViewState extends State<CollegeDetailView> {
  _fetchExploreData() async {
    try {
      if (_explore != null) return;
      _isLoading.value = true;

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/admin/data-explore/');
      if (response.statusCode == 200) {
        _explore = ExplorerModel.fromJson(response.data);
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
        if (_explore == null) {
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
                    //rowTitleText('Club Name', pref.token.value.name ?? 'N/A'),
                    //Gap(inset.sm),
                    BuildEventHistory(
                      data: _explore?.clubs ?? [],
                    ),
                  ],
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

  final List<Club> data;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.calendar_month),
                  Gap(inset.xs),
                  Column(
                    children: [
                      CustomText(
                        txt: data[index].authorityName ?? 'N/A',
                        color: context.theme.indigo,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ],
              ),
              Gap(inset.xs),
              rowTitleText(
                'Author',
                data[index].authorName ?? 'N/A',
              ),
              Gap(inset.sm),
              ListView.separated(
                itemCount: data[index].events?.length ?? 0,
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
                              txt: data[index].events?[indexS].eventName ??
                                  'N/A',
                              color: context.theme.indigo,
                            ),
                            rowTitleText('Event Fee',
                                "${data[index].events?[indexS].eventFee ?? 'N/A'}"),
                          ],
                        ),
                        rowTitleText('Date of Event',
                            data[index].events?[indexS].eventDate ?? 'N/A'),
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
