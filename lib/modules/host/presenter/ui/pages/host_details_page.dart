import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/controllers/host_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class HostDetailsPage extends StatefulWidget {
  static const route = '/HostDetails';
  const HostDetailsPage({super.key});
  @override
  State<HostDetailsPage> createState() => _HostDetailsPageState();
}

class _HostDetailsPageState extends State<HostDetailsPage> {
  final HostDetailsController ct = di();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    ct.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (ct.status) {
      case StatusBuild.loading:
        return Scaffold(
          appBar: AppBar(
            title: const Text('Host'),
          ),
          body: const LoadingAtom(),
        );
      default:
        var tipo = ct.host!.id == null ? 'Criar' : 'Alterar';
        return Scaffold(
          appBar: AppBar(
            title: Text('$tipo Host'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.defaultPadding),
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.defaultPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        CampoPadraoAtom(
                          hintText: 'Nome do host',
                          initialValue: ct.host!.name,
                          onChange: (v) => ct.host!.name = v,
                        ),
                        const SizedBox(height: AppTheme.defaultPadding * 2),
                        CampoPadraoAtom(
                          hintText: 'Url',
                          initialValue: ct.host!.host,
                          onChange: (v) => ct.host!.host = v,
                        ),
                        const SizedBox(height: AppTheme.defaultPadding * 2),
                        CampoPadraoAtom(
                          hintText: 'Id Ads tela cheia',
                          initialValue: ct.host!.interstitialAdUnitId,
                          onChange: (v) => ct.host!.interstitialAdUnitId = v,
                        ),
                        const SizedBox(height: AppTheme.defaultPadding * 2),
                        CampoPadraoAtom(
                          hintText: 'Ordem',
                          initialValue: ct.host!.order.toString(),
                          onChange: (v) =>
                              ct.host!.order = int.tryParse(v) ?? 0,
                        ),
                        const SizedBox(height: AppTheme.defaultPadding * 2),
                        CampoPadraoAtom(
                          hintText: 'Idhost',
                          initialValue: ct.host!.idHost.toString(),
                          onChange: (v) =>
                              ct.host!.idHost = int.tryParse(v) ?? 0,
                        ),
                        const SizedBox(height: AppTheme.defaultPadding * 2),
                        ButtonPadraoAtom(
                          title: '$tipo Host',
                          icone: Icons.create,
                          onPress: () => ct.saveHost(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}
