import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yab_yab_ai/core/utils/assets.dart';
import 'package:yab_yab_ai/core/utils/colors.dart';
import 'package:yab_yab_ai/core/utils/strings.dart';
import 'package:yab_yab_ai/core/utils/text_styles.dart';
import 'package:yab_yab_ai/features/screens/home/widgets/home_screen_list_view.dart';
import 'package:yab_yab_ai/features/screens/widgets/ads_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isConnected = false;
  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _checkInternetConnection().then((value) {
      setState(() {
        _isConnected = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: _isConnected
          ? Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 20, left: 15, right: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const Text(
                        AppStrings.hello,
                        style: AppTextStyle.styleRegularBlack30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(AppStrings.appName,
                          style: AppTextStyle.styleRegularBlack30
                              .copyWith(color: AppColors.primaryColor)),
                      const Spacer(),
                      SvgPicture.asset(
                        AppAssets.appIcon,
                        fit: BoxFit.scaleDown,
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                  HomeScreenListView(),
                  const SizedBox(height: 10,),
                  const AdsContainer(),
                  const SizedBox(height: 10,),

                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.wifi_off,
                    size: 50,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No internet connection',
                    style: AppTextStyle.styleRegularBlack30
                        .copyWith(color: Colors.grey, fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _checkInternetConnection().then((value) {
                          setState(() {
                            _isConnected = value;
                          });
                        });
                      });
                    },
                    child: Text(
                      'Try again',
                      style: AppTextStyle.styleRegularGrey18
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
