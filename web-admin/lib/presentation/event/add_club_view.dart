import 'package:app/domain/explorer/unverified_club_list_model/unverified_club_list_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

final ValueNotifier<bool> _isLoading = ValueNotifier(false);
List<UnverifiedClubListModel> _myClubs = [];

class AddClubView extends StatefulWidget {
  const AddClubView({super.key});

  @override
  State<AddClubView> createState() => _AddClubViewState();
}

class _AddClubViewState extends State<AddClubView> {
  refreshList() async {
    try {
      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/admin/unverified-club-list/');
      if (response.statusCode == 200) {
        _myClubs = (response.data as List)
            .map((e) => UnverifiedClubListModel.fromJson(e))
            .toList();
        _isLoading.value = true;
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = true;
      _isLoading.value = false;
    }
  }

  _fetchClubList() async {
    try {
      if (_myClubs.isNotEmpty) return;
      _isLoading.value = true;

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/admin/unverified-club-list/');
      if (response.statusCode == 200) {
        _myClubs = (response.data as List)
            .map((e) => UnverifiedClubListModel.fromJson(e))
            .toList();
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = false;
    }
  }

  final ValueNotifier<bool> _isVerifying = ValueNotifier(false);

  _verifyClub(BuildContext ctx, String id) async {
    try {
      _isVerifying.value = true;
      final response = await dioClient.dio
          .put('${Env().apiBaseUrl}home/admin/unverified-club-list/', data: {
        'club_id': id,
      });
      if (response.statusCode == 200) {
        if (ctx.mounted) {
          ctx.showCustomSnackBar('Verification Successful', Colors.green);
        }
        await refreshList();
        _isVerifying.value = false;
      }
    } on DioException catch (_) {
      if (ctx.mounted) {
        ctx.showCustomSnackBar('Verification Failed', Colors.red);
      }
      _isVerifying.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchClubList();
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
          if (_myClubs.isEmpty) {
            return const Center(
                child: CustomText(txt: 'No Unverified Authority'));
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(inset.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  txt: 'Verify Club',
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
                        itemCount: _myClubs.length,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: inset.xs,
                                  children: [
                                    CustomText(
                                      txt: _myClubs[index].authorityName ??
                                          'N/A',
                                      color: context.theme.indigo,
                                    ),
                                    rowTitleText('Authorizer',
                                        _myClubs[index].authorName ?? 'N/A'),
                                    rowTitleText('Email',
                                        _myClubs[index].email ?? 'N/A'),
                                  ],
                                ),

                                //rowTitleText('Website', 'Name'),
                                ValueListenableBuilder(
                                  valueListenable: _isVerifying,
                                  builder: (context, verify, _) {
                                    return CustomButton(
                                      width: 80,
                                      name:  'Verify',
                                      radius: 30,
                                      color: Colors.green,
                                      onTap: () {
                                              _verifyClub(
                                                  context,
                                                  _myClubs[index].authorityId ??
                                                      'N/A');
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

BoxDecoration applyBorderRadius(BuildContext context) {
  return BoxDecoration(
    color: context.theme.kWhite,
    borderRadius: BorderRadius.circular(10),
  );
}
