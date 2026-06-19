import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodking/app/modules/profile/views/pages_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../util/constant.dart';
import '../../../../util/localized_text.dart';
import '../../../../widget/loader.dart';
import '../../auth/views/login_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../order/views/order_view.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/profile_controller.dart';
import '../widget/change_language_view.dart';
import '../widget/change_password_view.dart';
import '../widget/edit_profile_view.dart';
import '../widget/profile_address_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  static const Color _ink = Color(0xff3b1726);
  static Color get _plum => AppColor.primaryColor;
  static const Color _muted = Color(0xff686071);
  static const Color _cream = Color(0xfffffbf4);
  static Color get _blush => AppColor.primaryColor.withValues(alpha: 0.12);
  static const Color _line = Color(0xffeadbd5);

  final box = GetStorage();

  bool get _isLoggedIn => box.read('isLogedIn') == true;

  @override
  void initState() {
    Get.put(SplashController());
    final profileController = Get.put(ProfileController());
    super.initState();
    if (_isLoggedIn) {
      profileController.getProfileData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) => Stack(
        children: [
          Scaffold(
            backgroundColor: _cream,
            body: RefreshIndicator(
              color: AppColor.primaryColor,
              onRefresh: () async {
                if (_isLoggedIn) {
                  await profileController.getProfileData();
                }
              },
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        _ProfileTopSection(
                          isLoggedIn: _isLoggedIn,
                          profileController: profileController,
                          onLogin: () async {
                            await Get.find<SplashController>()
                                .getConfiguration();
                            Get.to(() => LoginView());
                            if (mounted) setState(() {});
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: [
                              SizedBox(height: 24.h),
                              _SectionTitle(title: localizeText('Account')),
                              SizedBox(height: 14.h),
                              _AccountRows(
                                isLoggedIn: _isLoggedIn,
                                onDeleteAccount: () =>
                                    _showDeleteDialog(profileController),
                                onLoggedOut: () {
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: 22.h),
                              _ProfileFooterLinks(
                                isLoggedIn: _isLoggedIn,
                                onLoggedOut: () {
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: 96.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (profileController.loader)
            Positioned.fill(
              child: Container(
                color: Colors.white60,
                child: const Center(child: LoaderCircle()),
              ),
            ),
        ],
      ),
    );
  }

  void _showDeleteDialog(ProfileController profileController) {
    Get.dialog(
      AlertDialog(
        backgroundColor: _cream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        content: SizedBox(
          height: 166.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ARE_YOU_SURE_DELETE_THIS_ACCOUNT'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: _ink,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 26.h),
              Row(
                children: [
                  Expanded(
                    child: _DialogButton(
                      label: 'CLOSE'.tr,
                      foreground: _plum,
                      background: _blush,
                      onTap: Get.back,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: _DialogButton(
                      label: 'DELETE'.tr,
                      foreground: Colors.white,
                      background: AppColor.deleteBtnColor,
                      onTap: profileController.deleteAccount,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return ClipPath(
      clipper: _ProfileHeroClipper(),
      child: SizedBox(
        height: 300.h + topPadding,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/jamun bg.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.primaryColor.withValues(alpha: 0.36),
                    const Color(0xdffff8f1),
                  ],
                ),
              ),
            ),
            Positioned(
              top: topPadding + 26.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'MY_PROFILE'.tr,
                    style: GoogleFonts.playfairDisplay(
                      color: _ProfileViewState._ink,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.05,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    localizeText('Good drinks. Great moments.'),
                    style: TextStyle(
                      color: _ProfileViewState._muted,
                      fontFamily: 'Rubik',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTopSection extends StatelessWidget {
  const _ProfileTopSection({
    required this.isLoggedIn,
    required this.profileController,
    required this.onLogin,
  });

  final bool isLoggedIn;
  final ProfileController profileController;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final heroHeight = 300.h + topPadding;
    final cardTop = topPadding + 130.h;

    return SizedBox(
      height: cardTop + 270.h,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(top: 0, left: 0, right: 0, child: _ProfileHero()),
          Positioned(
            top: heroHeight - 2.h,
            left: 0,
            right: 0,
            child: Container(height: 72.h, color: _ProfileViewState._cream),
          ),
          Positioned(
            top: cardTop,
            left: 24.w,
            right: 24.w,
            child: isLoggedIn
                ? _ProfileSummaryCard(controller: profileController)
                : _LoginCard(onLogin: onLogin),
          ),
        ],
      ),
    );
  }
}

class _ProfileSummaryCard extends StatelessWidget {
  const _ProfileSummaryCard({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final data = controller.profileData;
    final name = _readable(data.name) == 'Guest'
        ? '${_readable(data.firstName, fallback: '')} ${_readable(data.lastName, fallback: '')}'
              .trim()
        : _readable(data.name);
    final email = _readable(data.email, fallback: 'nipun@gmail.com');
    final phone =
        '${_readable(data.countryCode, fallback: '')} ${_readable(data.phone, fallback: '')}'
            .trim();
    final currencySymbol =
        Get.find<SplashController>().configData.siteDefaultCurrencySymbol ??
        String.fromCharCode(0x00A3);
    final balance =
        data.currencyBalance ?? '$currencySymbol${data.balance ?? '0.00'}';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 18.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: 0.11),
            blurRadius: 28,
            offset: Offset(0, 14.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Transform.translate(
            offset: Offset(0, -32.h),
            child: _Avatar(controller: controller),
          ),
          Transform.translate(
            offset: Offset(0, -17.h),
            child: Column(
              children: [
                Text(
                  name.isEmpty ? localizeText('Guest') : name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    color: _ProfileViewState._ink,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.05,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _subTextStyle(fontSize: 13.sp),
                ),
                if (phone.isNotEmpty) ...[
                  SizedBox(height: 6.h),
                  Text(phone, style: _subTextStyle(fontSize: 13.sp)),
                ],
                SizedBox(height: 17.h),
                Divider(color: _ProfileViewState._line, height: 1.h),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SoftIcon(icon: Icons.account_balance_wallet_outlined),
                    SizedBox(width: 13.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizeText('Wallet Balance'),
                          style: _subTextStyle(fontSize: 13.sp),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          balance,
                          style: GoogleFonts.roboto(
                            color: _ProfileViewState._plum,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.controller});

  final ProfileController controller;

  bool _useLocalPlaceholder(String? image) {
    if (image == null || image.isEmpty) return true;
    return image.contains('/images/default/profile.png');
  }

  @override
  Widget build(BuildContext context) {
    final image = controller.profileData.image;

    return SizedBox(
      height: 116.w,
      width: 116.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: _ProfileViewState._plum, width: 1.2.w),
            ),
            child: ClipOval(
              child: SizedBox(
                height: 108.w,
                width: 108.w,
                child: _useLocalPlaceholder(image)
                    ? Image.asset(Images.profile, fit: BoxFit.cover)
                    : CachedNetworkImage(
                        imageUrl: image!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: _ProfileViewState._blush),
                        errorWidget: (context, url, error) =>
                            Image.asset(Images.profile, fit: BoxFit.cover),
                      ),
              ),
            ),
          ),
          Positioned(
            right: -2.w,
            bottom: 10.h,
            child: InkWell(
              onTap: controller.getImageFromGallary,
              borderRadius: BorderRadius.circular(22.r),
              child: Container(
                height: 40.w,
                width: 40.w,
                decoration: BoxDecoration(
                  color: _ProfileViewState._plum,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _ProfileViewState._plum.withValues(alpha: 0.24),
                      blurRadius: 14,
                      offset: Offset(0, 6.h),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.photo_camera_rounded,
                  color: Colors.white,
                  size: 19.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard({required this.onLogin});

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: 0.10),
            blurRadius: 26,
            offset: Offset(0, 14.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            Images.profile,
            height: 92.w,
            width: 92.w,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16.h),
          Text(
            'LOGIN_TO_SEE_YOUR_INFO'.tr,
            textAlign: TextAlign.center,
            style: _rowTextStyle(),
          ),
          SizedBox(height: 22.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: onLogin,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: _ProfileViewState._plum,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                'LOGIN'.tr,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.playfairDisplay(
            color: _ProfileViewState._plum,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
        SizedBox(width: 18.w),
        Row(
          children: List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.only(right: index == 2 ? 0 : 8.w),
              child: Container(
                height: 4.w,
                width: 4.w,
                decoration: BoxDecoration(
                  color: _ProfileViewState._plum.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 13.w),
        Expanded(
          child: Container(height: 1.h, color: _ProfileViewState._line),
        ),
      ],
    );
  }
}

class _AccountRows extends StatelessWidget {
  const _AccountRows({
    required this.isLoggedIn,
    required this.onDeleteAccount,
    required this.onLoggedOut,
  });

  final bool isLoggedIn;
  final VoidCallback onDeleteAccount;
  final VoidCallback onLoggedOut;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[
      if (isLoggedIn)
        _ProfileMenuRow(
          icon: Icons.shopping_bag_outlined,
          label: 'MY_ORDERS'.tr,
          onTap: () =>
              Get.to(() => const OrderView(), transition: Transition.cupertino),
        ),
      if (isLoggedIn)
        _ProfileMenuRow(
          icon: Icons.edit_outlined,
          label: 'EDIT_PROFILE'.tr,
          onTap: () =>
              Get.to(() => EditProfileView(), transition: Transition.cupertino),
        ),
      if (isLoggedIn)
        _ProfileMenuRow(
          icon: Icons.location_on_outlined,
          label: 'ADDRESS'.tr,
          onTap: () => Get.to(
            () => const ProfileAddressView(),
            transition: Transition.cupertino,
          ),
        ),
      if (isLoggedIn)
        _ProfileMenuRow(
          icon: Icons.lock_outline_rounded,
          label: 'CHANGE_PASSWORD'.tr,
          onTap: () => Get.to(
            () => ChangePasswordView(),
            transition: Transition.cupertino,
          ),
        ),
      _ProfileMenuRow(
        icon: Icons.language_rounded,
        label: 'CHANGE_LANGUAGE'.tr,
        onTap: () => Get.to(
          () => const ChangeLanguageView(),
          transition: Transition.cupertino,
        ),
      ),
      if (isLoggedIn)
        _ProfileMenuRow(
          icon: Icons.delete_outline_rounded,
          label: 'DELETE_ACCOUNT'.tr,
          isDanger: true,
          onTap: onDeleteAccount,
        ),
    ];

    return Column(
      children: [
        ...rows.expand((row) => [row, SizedBox(height: 9.h)]),
      ],
    );
  }
}

class _ProfileMenuRow extends StatelessWidget {
  const _ProfileMenuRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDanger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final color = isDanger ? AppColor.deleteBtnColor : _ProfileViewState._ink;
    final accent = isDanger ? AppColor.deleteBtnColor : _ProfileViewState._plum;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        height: 58.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withValues(alpha: 0.055),
              blurRadius: 18,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        child: Row(
          children: [
            _SoftIcon(icon: icon, color: accent),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: color,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: accent, size: 25.sp),
          ],
        ),
      ),
    );
  }
}

class _ProfileFooterLinks extends StatelessWidget {
  const _ProfileFooterLinks({
    required this.isLoggedIn,
    required this.onLoggedOut,
  });

  final bool isLoggedIn;
  final VoidCallback onLoggedOut;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (splashController) {
        final links = splashController.pageDataList
            .where((page) {
              final title = page.title?.toString().trim() ?? '';
              return title.isNotEmpty &&
                  !title.toLowerCase().contains('delete account');
            })
            .map<Widget>(
              (page) => _FooterLink(
                title: localizeText(page.title.toString()),
                onTap: () => Get.to(
                  () => PagesScreen(
                    description: localizeText(page.description),
                    tittle: localizeText(page.title),
                  ),
                  transition: Transition.cupertino,
                ),
              ),
            )
            .toList();

        if (links.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            Divider(color: _ProfileViewState._line, height: 1.h),
            SizedBox(height: 13.h),
            Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: 14.w,
              runSpacing: 6.h,
              children: [
                for (int i = 0; i < links.length; i++) ...[
                  links[i],
                  if (i != links.length - 1)
                    Text(
                      '|',
                      style: TextStyle(
                        color: _ProfileViewState._line,
                        fontSize: 11.sp,
                      ),
                    ),
                ],
              ],
            ),
            if (isLoggedIn) ...[
              SizedBox(height: 18.h),
              SizedBox(
                width: double.infinity,
                height: 46.h,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final box = GetStorage();
                    box.write('isLogedIn', false);
                    onLoggedOut();
                    Get.offAll(() => const DashboardView());
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  label: Text(
                    'LOG_OUT'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: _ProfileViewState._plum,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23.r),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
        child: Text(
          title,
          style: TextStyle(
            color: _ProfileViewState._plum,
            fontFamily: 'Rubik',
            fontSize: 11.5.sp,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
            decorationColor: _ProfileViewState._plum,
          ),
        ),
      ),
    );
  }
}

class _SoftIcon extends StatelessWidget {
  const _SoftIcon({required this.icon, this.color});

  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? AppColor.primaryColor;

    return Container(
      height: 39.w,
      width: 39.w,
      decoration: BoxDecoration(
        color: AppColor.primaryColor.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: 20.sp),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.foreground,
    required this.background,
    required this.onTap,
  });

  final String label;
  final Color foreground;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.r),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: foreground,
            fontFamily: 'Rubik',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ProfileHeroClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 44);
    path.cubicTo(
      size.width * 0.22,
      size.height - 14,
      size.width * 0.48,
      size.height - 24,
      size.width * 0.70,
      size.height - 10,
    );
    path.cubicTo(
      size.width * 0.84,
      size.height - 2,
      size.width * 0.94,
      size.height - 22,
      size.width,
      size.height - 32,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

TextStyle _subTextStyle({required double fontSize}) {
  return TextStyle(
    fontFamily: 'Rubik',
    color: _ProfileViewState._muted,
    fontSize: fontSize,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );
}

TextStyle _rowTextStyle() {
  return TextStyle(
    fontFamily: 'Rubik',
    color: _ProfileViewState._ink,
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
  );
}

String _readable(String? value, {String fallback = 'Guest'}) {
  if (value == null || value.trim().isEmpty || value == 'null') {
    return fallback;
  }
  return value.trim();
}
