import 'package:dashboard_manga_easy/modules/toggles/data/dtos/create_toggle_dto.dart';
import 'package:dashboard_manga_easy/modules/toggles/data/repositories/toggle_repository.dart';
import 'package:dashboard_manga_easy/modules/toggles/domain/entities/toggle_entity.dart';
import 'package:dashboard_manga_easy/modules/toggles/presenter/ui/events/details_banner_event.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class CreateToggleController extends ManagerStore<DetailsTogglesEvent> {
  final ToggleRepositoryV1 _toggleRepository;
  ToggleEntity? toggle;
  CreateToggleDto dto = CreateToggleDto.empty();

  CreateToggleController(this._toggleRepository);

  @override
  Future<void> init(Map<String, dynamic> arguments) async {
    final String? name = arguments['name'];
    if (name != 'create') {
      final toggle = await _toggleRepository.list(name: name);
      if (toggle.isNotEmpty) {
        dto = CreateToggleDto.fromEntity(toggle.first);
      }
    }
    state = StateManager.done;
  }

  void criarBanner() => handleTry(
        call: () async {
          String tipo = 'criado';
          if (toggle == null) {
            await _toggleRepository.create(dto: dto);
          } else {
            await _toggleRepository.update(dto: dto, id: toggle!.id);
            tipo = 'salvo';
          }
          emitNavigation(DetailsTogglesEventSuccess(tipo));
        },
        showDialogError: true,
        onCatch: StateManager.done,
      );
}
