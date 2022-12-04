import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/configApp/presenter/controllers/config_app_controllers.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/switch_default.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/views/cria_edita_emblema_page.dart';
import 'package:flutter/material.dart';

class ConfigAppPage extends StatefulWidget {
  static const route = '/ConfigApp';
  const ConfigAppPage({Key? key}) : super(key: key);

  @override
  State<ConfigAppPage> createState() => _ConfigAppPageState();
}

class _ConfigAppPageState extends State<ConfigAppPage> {
  final ConfigAppController ct = di();

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
    return ModuloPageTemplate(
      route: ConfigAppPage.route,
      statusBuild: ct.status,
      child: Expanded(
        child: ListView(
          children: [
            CampoPadraoAtom(
              hintText: 'Link politica de privacidade',
              initialValue: ct.config.politica,
              onChange: (v) => ct.config.politica = v,
            ),
            const SizedBox(height: 5),
            CampoPadraoAtom(
              hintText: 'Host Appwrite',
              initialValue: ct.config.hostAppwrite,
              onChange: (v) => ct.config.hostAppwrite = v,
            ),
            const SizedBox(height: 5),
            CampoPadraoAtom(
              hintText: 'Link convite Discord',
              initialValue: ct.config.linkDiscord,
              onChange: (v) => ct.config.linkDiscord = v,
            ),
            const SizedBox(height: 5),
            CampoPadraoAtom(
              keyboardType: TextInputType.number,
              hintText: 'Número da build para atualização',
              initialValue: ct.config.build.toString(),
              onChange: (v) => ct.config.build = int.parse(v),
            ),
            const SizedBox(height: 5),
            SwitchDefault(
              title: 'Ativar sistema de nivel',
              value: ct.config.nivelAtivo,
              onChanged: (v) {
                ct.config.nivelAtivo = v;
                ct.notifyListeners();
              },
            ),
            const SizedBox(height: 5),
            SwitchDefault(
              title: 'Ativar Appwrite',
              value: ct.config.ativaAppwrite,
              onChanged: (v) {
                ct.config.ativaAppwrite = v;
                ct.notifyListeners();
              },
            ),
            const SizedBox(height: 5),
            SwitchDefault(
              title: 'Ativar atualização dos views',
              value: ct.config.isViews,
              onChanged: (v) {
                ct.config.isViews = v;
                ct.notifyListeners();
              },
            ),
            const SizedBox(height: 5),
            SwitchDefault(
              title: 'Ativar atualização do catalogo',
              value: ct.config.isCatalog,
              onChanged: (v) {
                ct.config.isCatalog = v;
                ct.notifyListeners();
              },
            ),
            const SizedBox(height: 5),
            SwitchDefault(
              title: 'Ativar ADS',
              value: ct.config.adsOn,
              onChanged: (v) {
                ct.config.adsOn = v;
                ct.notifyListeners();
              },
            ),
            const SizedBox(height: 15),
            ButtonPadraoAtom(
              title: 'Salvar',
              icone: Icons.save,
              onPress: () => ct.updateConfig(context),
            ),
          ],
        ),
      ),
    );
  }
}
