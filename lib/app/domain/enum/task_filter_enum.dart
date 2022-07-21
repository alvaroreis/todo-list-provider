enum TaskFilterEnum {
  today('DE HOJE'),
  tomorrow('DE AMANHÃ'),
  week('DA SEMANA'),
  finish('CONCLUÍDAS');

  final String description;
  const TaskFilterEnum(this.description);
}
