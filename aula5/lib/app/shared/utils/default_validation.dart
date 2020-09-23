import 'package:aula5/generated/l10n.dart';

String validateMandatoryField(dynamic value) {
  if (value is String && value.isEmpty || value == null) {
    return S.current.mandatoryField;
  }
  return null;
}
