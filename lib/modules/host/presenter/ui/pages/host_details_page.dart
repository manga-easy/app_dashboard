import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/controllers/host_details_controller.dart';
import 'package:flutter/material.dart';

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
    ct.onMessage(listernerMessage);
    super.initState();
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  void listernerMessage(String? message) {
    if (message != null && mounted) {
      AppHelps.confirmaDialog(
        title: 'Error ⚠️😥',
        content: message,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tipo = ct.host?.id == null ? 'Criar' : 'Alterar';
    return DefaultPageTemplate(
      state: ct.state,
      done: Scaffold(
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
                        initialValue: ct.dto.name,
                        onChange: (v) => ct.dto.name = v,
                      ),
                      const SizedBox(height: AppTheme.defaultPadding * 2),
                      CampoPadraoAtom(
                        hintText: 'Url',
                        initialValue: ct.dto.urlApi,
                        onChange: (v) => ct.dto.urlApi = v,
                      ),
                      const SizedBox(height: AppTheme.defaultPadding * 2),
                      CampoPadraoAtom(
                        hintText: 'Ordem',
                        initialValue: ct.dto.order.toString(),
                        onChange: (v) => ct.dto.order = int.tryParse(v) ?? 0,
                      ),
                      const SizedBox(height: AppTheme.defaultPadding * 2),
                      CampoPadraoAtom(
                        hintText: 'Idhost',
                        initialValue: ct.dto.hostId.toString(),
                        onChange: (v) => ct.dto.hostId = int.tryParse(v) ?? 0,
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
      ),
    );
  }
}
