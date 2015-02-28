import 'dart:async';
import 'dart:mirrors';
import 'package:annotate/annotate.dart';
import 'package:unittest/unittest.dart';
import 'test_data.dart';

final String nl = "\n     ";

void main() {
  group('', () {
    test('When I test for annotations on an annotated type${nl} Then the test is successful',
      () => when(testAnnotatedClass).then(annotationIsPresent)
    );
    test('When I test for missing annotations on an annotated type${nl} Then the test fails',
      () => when(testAnnotatedClassForMissingAnnotations).then(annotationIsMissing)
    );
    test('When I test for annotations on an unannotated type${nl} Then the test fails',
      () => when(testUnannotatedClass).then(annotationIsMissing)
    );
  });

  group('Given an annotated object${nl}', () {
    Object object;

    setUp(() {
      object = new AnnotatedClass.annotatedConstructor();
    });
    test('When I test for annotations${nl} Then the test is successful',
      () => when(testObject(object)).then(annotationIsPresent)
    );
    test('When I test for missing annotations${nl} Then the test fails',
      () => when(testObjectForMissingAnnotations(object)).then(annotationIsMissing)
    );
  });

  group('Given an unannotated object${nl}', () {
    Object object;

    setUp(() {
      object = new UnannotatedClass();
    });
    test('When I test for annotations${nl} Then the test fails',
      () => when(testObject(object)).then(annotationIsMissing)
    );
  });

  group('Given an object with annotated methods${nl}', () {
    Object object;

    setUp(() {
      object = new AnnotatedClass.annotatedConstructor();
    });
    test('When I test for methods with an annotation${nl} Then some methods are found',
      () => when(testMethods(object)).then(someResultsFound)
    );
    test('When I test for methods with a missing annotation${nl} Then no methods are found',
      () => when(testMethodsForMissingAnnotations(object)).then(noResultsFound)
    );
    test('When I test for static methods with an annotation${nl} Then some methods are found',
      () => when(testStaticMethods(object)).then(someResultsFound)
    );
    test('When I test for static methods with a missing annotation${nl} Then no methods are found',
      () => when(testStaticMethodsForMissingAnnotations(object)).then(noResultsFound)
    );
    test('When I find methods with an annotation${nl} Then setters and getters are found',
      () => when(testMethods(object)).then(resultsContainGettersAndSetters)
    );
  });

  group('Given an object with annotated fields${nl}', () {
    Object object;

    setUp(() {
      object = new AnnotatedClass.annotatedConstructor();
    });
    test('When I test static and instance fields for an annotation${nl} Then some fields are found',
      () => when(testFields(object)).then(someResultsFound)
    );
    test('When I test static and instance fields for a missing annotation${nl} Then no fields are found',
      () => when(testFieldsForMissingAnnotations(object)).then(noResultsFound)
    );
  });

  group('Given a method with annotated parameters${nl}', () {
    MethodMirror method;
    Symbol methodName = const Symbol('method');

    setUp(() {
      method = reflect(new AnnotatedClass.annotatedConstructor())
          .type.instanceMembers[methodName];
    });
    test('When I test method parameters for an annotation${nl} Then some parameters are found',
      () => when(testParameters(method)).then(someResultsFound)
    );
    test('When I test method parameters for a missing annotation${nl} Then no parameters are found',
      () => when(testParametersForMissingAnnotations(method)).then(noResultsFound)
    );
  });
}

typedef dynamic Clause();

Future<dynamic> given(Clause clause) => new Future.value(clause());
Future<dynamic> when(Clause clause) => new Future.value(clause());

bool testAnnotatedClass() =>
  new TypeAnnotationFacade(AnnotatedClass).hasAnnotationOf(Annotation);

bool testAnnotatedClassForMissingAnnotations() =>
  new TypeAnnotationFacade(AnnotatedClass).hasAnnotationOf(MissingAnnotation);

bool testUnannotatedClass() =>
  new TypeAnnotationFacade(UnannotatedClass).hasAnnotationOf(Annotation);

Clause testObject(Object object) =>
  () => new InstanceAnnotationFacade(object).hasAnnotationOf(Annotation);

Clause testObjectForMissingAnnotations(Object object) =>
  () => new InstanceAnnotationFacade(object).hasAnnotationOf(MissingAnnotation);

Clause testMethods(Object object) =>
  () => reflect(object).type.instanceMembers.values
    .where(DeclarationAnnotationFacade.filterByAnnotation(Annotation));

Clause testMethodsForMissingAnnotations(Object object) =>
  () => reflect(object).type.instanceMembers.values
    .where(DeclarationAnnotationFacade.filterByAnnotation(MissingAnnotation));

Clause testStaticMethods(Object object) =>
  () => reflect(object).type.staticMembers.values
    .where(DeclarationAnnotationFacade.filterByAnnotation(Annotation));

Clause testStaticMethodsForMissingAnnotations(Object object) =>
  () => reflect(object).type.staticMembers.values
    .where(DeclarationAnnotationFacade.filterByAnnotation(MissingAnnotation));

Clause testFields(Object object) =>
  () => reflect(object).type.declarations.values
    .where(isVariableMirror)
    .map(toVariableMirror)
    .where(DeclarationAnnotationFacade.filterByAnnotation(Annotation));

Clause testFieldsForMissingAnnotations(Object object) =>
  () => reflect(object).type.declarations.values
    .where(isVariableMirror)
    .map(toVariableMirror)
    .where(DeclarationAnnotationFacade.filterByAnnotation(MissingAnnotation));

bool isVariableMirror(DeclarationMirror mirror) =>
  mirror is VariableMirror;

VariableMirror toVariableMirror(DeclarationMirror mirror) =>
  mirror as VariableMirror;

Clause testParameters(MethodMirror method) =>
  () => method.parameters
    .where(DeclarationAnnotationFacade.filterByAnnotation(Annotation));

Clause testParametersForMissingAnnotations(MethodMirror method) =>
  () => method.parameters
    .where(DeclarationAnnotationFacade.filterByAnnotation(MissingAnnotation));

void annotationIsPresent(bool result) {
  expect(result, isTrue);
}

void annotationIsMissing(bool result) {
  expect(result, isFalse);
}

void someResultsFound(Iterable<dynamic> result) {
  expect(result, isNotEmpty);
}

void noResultsFound(Iterable<dynamic> result) {
  expect(result, isEmpty);
}

void resultsContainGettersAndSetters(Iterable<MethodMirror> result) {
  Symbol getterName, setterName;
  bool hasGetters, hasSetters;

  getterName = const Symbol('annotatedGetter');
  hasGetters = result.any((MethodMirror method) => method.simpleName == getterName);

  setterName = const Symbol('annotatedSetter=');
  hasSetters = result.any((MethodMirror method) => method.simpleName == setterName);

  expect(hasGetters, isTrue);
  expect(hasSetters, isTrue);
}

// vim: set ai et sw=2 syntax=dart :
