
class Annotation {
  const Annotation();
}

class MissingAnnotation {
  const MissingAnnotation();
}

@Annotation()
class AnnotatedClass {

  @Annotation() static String annotatedStaticField = '';
  @Annotation() String annotatedField = '';

  static String unannotatedStaticField = '';
  String unannotatedField = '';

  @Annotation() AnnotatedClass.annotatedConstructor();

  AnnotatedClass.unannotatedConstructor();

  @Annotation() String get annotatedGetter => '';
  @Annotation() set annotatedSetter(String value) {}

  String get unannotatedGetter => '';
  set unannotatedSetter(String value) {}

  @Annotation() static void annotatedStaticMethod() {}
  @Annotation() void annotatedMethod() {}

  void unannotatedStaticMethod() {}
  void unannotatedMethod() {}

  void method(@Annotation() String annotatedParameter, String unannotatedParameter) {}
}

class UnannotatedClass {

}

// vim: set ai et sw=2 syntax=dart :
