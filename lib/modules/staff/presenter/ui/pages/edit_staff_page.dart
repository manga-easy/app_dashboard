import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/organisms/select_user.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/atoms/name_user_build.dart';
import 'package:dashboard_manga_easy/modules/staff/domain/models/staff_entity.dart';
import 'package:dashboard_manga_easy/modules/staff/presenter/controllers/edit_staff_controller.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/manager_page.dart';

class EditStaffPage extends StatefulWidget {
  const EditStaffPage({super.key});

  @override
  State<EditStaffPage> createState() => _EditStaffPageState();
}

class _EditStaffPageState
    extends ManagerPage<EditStaffController, EditStaffPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultPageTemplate(
      state: ct.state,
      error: ct.error,
      appBar: Text(ct.appBarText),
      pageDone: () => ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.defaultPadding,
        ),
        children: [
          DropdownButton<int>(
            isExpanded: true,
            value: ct.selectedType,
            items: StaffType.values
                .where((type) => type != StaffType.unknown)
                .map(
                  (type) => DropdownMenuItem<int>(
                    value: type.index,
                    child: Text(ct.convertStaffType(type)),
                  ),
                )
                .toList(),
            onChanged: (int? v) {
              setState(() {
                ct.selectedType = v;
                ct.updateStaffType(v);
              });
            },
          ),
          const SizedBox(height: AppTheme.defaultPadding),
          OutlinedButton(
            onPressed: ct.id == 'create'
                ? () async {
                    final user = await AppHelps.bottomSheet(
                      context: context,
                      child: SelectUser(future: ct.findStaff),
                    );
                    if (user is User) {
                      setState(() {
                        ct.assignUser(user.id!);
                      });
                    }
                  }
                : null,
            child: NameUserBuild(
              future: ct.getEmail(
                userId: ct.staffDetail?.userId ?? '',
              ),
            ),
          ),
          const SizedBox(height: AppTheme.defaultPadding),
          ButtonPadraoAtom(
            title: 'Salvar Staff',
            icone: Icons.save,
            onPress: () => ct.saveEditStaff(context),
          ),
        ],
      ),
    );
  }
}
