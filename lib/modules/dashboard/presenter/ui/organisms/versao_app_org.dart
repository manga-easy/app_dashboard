import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersaoAppOrg extends StatefulWidget {
  const VersaoAppOrg({super.key});

  @override
  State<VersaoAppOrg> createState() => _VersaoAppOrgState();
}

class _VersaoAppOrgState extends State<VersaoAppOrg> {
  PackageInfo? pkgInfo;
  @override
  void initState() {
    getInforPackge();
    super.initState();
  }

  Future<void> getInforPackge() async {
    pkgInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (pkgInfo == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Text('v${pkgInfo!.version}+${pkgInfo!.buildNumber}');
  }
}
