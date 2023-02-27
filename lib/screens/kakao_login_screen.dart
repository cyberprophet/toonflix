import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoLogin extends StatelessWidget {
  const KakaoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: TextButton(
        onPressed: kakaoLogin,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                offset: const Offset(
                  7.5,
                  7.5,
                ),
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          child: Image.network(
              fit: BoxFit.fill,
              'https://coreapi.shareinvest.net/images/buttons/kakao_login_medium_wide.png'),
        ),
      ),
    );
  }

  kakaoLogin() async {
    KakaoSdk.init(
      nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY'],
    );
    final installed = await isKakaoTalkInstalled();

    final info = await UserApi.instance.accessTokenInfo();

    final auth = installed
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();

    final user = await UserApi.instance.me();

    if (kDebugMode) {
      if (auth.scopes == null) {
        return;
      }
      for (var scope in auth.scopes!) {
        print(scope);
      }
      print({
        info.appId,
        info.id,
        info.expiresIn,
        user.kakaoAccount?.email,
      });
    }
  }
}
