import 'package:aula5/generated/l10n.dart';

String validateMandatoryField(String value) {
  if (value.isEmpty) {
    return S.current.mandatoryField;
  }
  return null;
}
