import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/widgets/side_menu.dart';
import 'package:dashboard_manga_easy/modules/users/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/views/widgets/emblemas_users.dart';
import 'package:dashboard_manga_easy/modules/users/views/widgets/info_users.dart';
import 'package:flutter/material.dart';

class UserDetalhesPage extends StatefulWidget {
  static const route = '/UserDetalhes';
  const UserDetalhesPage({Key? key}) : super(key: key);
  @override
  State<UserDetalhesPage> createState() => _UserDetalhesPageState();
}

class _UserDetalhesPageState extends State<UserDetalhesPage> {
  final ct = di.get<UsersDetalhesController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.onInit(context));
    super.initState();
  }

  @override
  void dispose() {
    ct.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: SideMenu(atual: UserDetalhesPage.route),
      appBar: AppBar(
        title: Text(ct.user!.name),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ct.showAddemblema(context),
        label: const Text('Adicionar emblema'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: ct.status,
          builder: (context, value, child) {
            if (ct.user == null) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Column(
              //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: InfoUsersW(
                    user: ct.user!,
                    onPress: () => ct.addNotificacao(context),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  child: EmblemasUsersW(
                    ct: ct,
                    list: ct.emblemasUsers,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
