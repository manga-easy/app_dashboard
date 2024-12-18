import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/staff/presenter/controllers/staff_controller.dart';
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
        final staff = ct.staffList[index];

        return Card(
          child: ListTile(
            onTap: () => context
                .push('${StaffPage.route}/${staff.id}')
                .then((value) => ct.getList()),
            title: Text(
              staff.name ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              'Cargo: ${ct.convertStaffType(staff.type)}',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () => ct.delete(staff.userId, context),
            ),
          ),
        );
      },
      listaItems: ct.staffList,
    );
  }
}
