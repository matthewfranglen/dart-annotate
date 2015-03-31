library annotate.example;

import 'dart:mirrors';
import 'package:annotate/annotate.dart';

void main() {
  Iterable<dynamic> objects = [
    new ExampleAnnotatedClass(),
    new ExampleUnannotatedClass()
  ];

  print("When inspecting a list of objects (${describeObjects(objects)})");

  Iterable<dynamic> filteredObjects =
    objects.where(InstanceAnnotationFacade.filterByAnnotation(ExampleAnnotation));

  print("I find that only some objects have the annotation (${describeObjects(filteredObjects)})");

  Iterable<Type> types =
    [ExampleAnnotatedClass, ExampleUnannotatedClass];

  print("When inspecting a list of types (${types.join(", ")})");

  Iterable<Type> filteredTypes =
    types.where(TypeAnnotationFacade.filterByAnnotation(ExampleAnnotation));

  print("I find that only some types have the annotation (${filteredTypes.join(", ")})");

  Iterable<DeclarationMirror> declarations =
    reflect(new ExampleClass()).type.declarations.values;

  print("When inspecting a list of declarations (${declarations.join(", ")})");

  Iterable<DeclarationMirror> filteredDeclarations =
    declarations.where(DeclarationAnnotationFacade.filterByAnnotation(ExampleAnnotation));

  print("I find that only some declarations have the annotation (${filteredDeclarations.join(", ")})");
}

String describeObjects(Iterable<dynamic> objects) =>
  objects.map((o) => o.runtimeType.toString()).join(", ");

class ExampleAnnotation {
  const ExampleAnnotation();
}

const ExampleAnnotation exampleAnnotation = const ExampleAnnotation();


@exampleAnnotation class ExampleAnnotatedClass {}

class ExampleUnannotatedClass {}

class ExampleClass {

  @exampleAnnotation int annotatedField;
  int unannotatedField;

  @exampleAnnotation void annotatedMethod() {}
  void unannotatedMethod() {}
}

// vim: set ai et sw=2 syntax=dart :
