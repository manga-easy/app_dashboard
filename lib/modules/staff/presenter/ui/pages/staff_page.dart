import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/staff/presenter/controllers/staff_controller.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/manager_page.dart';

class StaffPage extends StatefulWidget {
  static const route = '/staff';
  const StaffPage({super.key});
  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends ManagerPage<StaffController, StaffPage> {
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: StaffPage.route,
      state: ct.state,
      error: ct.error,
      labelNovoItem: 'Adicionar Staff',
      onPressedAtualiza: ct.getList,
      onPressedNovoItem: () => context.push('${StaffPage.route}/create'),
      itemBuilderLista: (context, index) {
        final data = ct.staffList[index];

        return FutureBuilder<List<User>>(
          future: ct.findStaff(data.userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final user = snapshot.data!.first;
              return Card(
                child: ListTile(
                  onTap: () => context
                      .push('${StaffPage.route}/${data.id}')
                      .then((value) => ct.getList()),
                  title: Text(
                    ct.validateUserName(user) ?? data.userId,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    'Cargo: ${ct.convertStaffType(data.type)}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () => ct.delete(data.userId, context),
                  ),
                ),
              );
            } else {
              return const Center(child: Text('Nenhum dado encontrado'));
            }
          },
        );
      },
      listaItems: ct.staffList,
    );
  }
}
