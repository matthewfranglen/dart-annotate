import 'dart:async';
import 'dart:mirrors';
import 'package:annotate/annotate.dart';
import 'package:unittest/unittest.dart';
import 'package:behave/behave.dart';
import 'test_data.dart';

final String nl = "\n     ";

void main() {
  Feature feature = new Feature("Can test for annotations");

  feature.load(new _Steps());

  feature.scenario("Inspecting types for annotations")
    .when("I test for annotations on an annotated type")
    .then("the test is successful")
    .test();

  feature.scenario("Inspecting types for annotations")
    .when("I test for annotations on an unannotated type")
    .then("the test fails")
    .test();

  feature.scenario("Inspecting instances for annotations")
    .given("an annotated object")
    .when("I test for annotations")
    .then("the test is successful")
    .test();

  feature.scenario("Inspecting instances for annotations")
    .given("an annotated object")
    .when("I test for missing annotations")
    .then("the test fails")
    .test();

  feature.scenario("Inspecting instances for annotations")
    .given("an unannotated object")
    .when("I test for annotations")
    .then("the test fails")
    .test();

  feature.scenario("Inspecting instances for annotated methods")
    .given("an object with annotated methods")
    .when("I test for methods with an annotation")
    .then("some methods are found")
    .test();

  feature.scenario("Inspecting instances for annotated methods")
    .given("an object with annotated methods")
    .when("I test for methods with a missing annotation")
    .then("no methods are found")
    .test();

  feature.scenario("Inspecting instances for annotated methods")
    .given("an object with annotated methods")
    .when("I test for static methods with an annotation")
    .then("some methods are found")
    .test();

  feature.scenario("Inspecting instances for annotated methods")
    .given("an object with annotated methods")
    .when("I test for static methods with a missing annotation")
    .then("no methods are found")
    .test();

  feature.scenario("Inspecting instances for annotated methods")
    .given("an object with annotated methods")
    .when("I find methods with an annotation")
    .then("getters and setters are found")
    .test();

  feature.scenario("Inspecting instances for annotated fields")
    .given("an object with annotated fields")
    .when("I test static and instance fields for an annotation")
    .then("some fields are found")
    .test();

  feature.scenario("Inspecting instances for annotated fields")
    .given("an object with annotated fields")
    .when("I test static and instance fields for a missing annotation")
    .then("no fields are found")
    .test();

  feature.scenario("Inspecting methods for annotated parameters")
    .given("a method with annotated parameters")
    .when("I test method parameters for an annotation")
    .then("some parameters are found")
    .test();

  feature.scenario("Inspecting methods for annotated parameters")
    .given("a method with annotated parameters")
    .when("I test method parameters for a missing annotation")
    .then("no parameters are found")
    .test();
}

class _Steps {
  @Given("a method with annotated parameters")
  void givenAMethodWithAnnotatedParameters(Map<String, dynamic> context) {

  }

  @Given("an annotated object")
  void givenAnAnnotatedObject(Map<String, dynamic> context) {

  }

  @Given("an object with annotated fields")
  void givenAnObjectWithAnnotatedFields(Map<String, dynamic> context) {

  }

  @Given("an object with annotated methods")
  void givenAnObjectWithAnnotatedMethods(Map<String, dynamic> context) {

  }

  @Given("an unannotated object")
  void givenAnUnannotatedObject(Map<String, dynamic> context) {

  }

  @When("I find methods with an annotation")
  void whenIFindMethodsWithAnAnnotation(Map<String, dynamic> context) {

  }

  @When("I test for annotations on an annotated type")
  void whenITestForAnnotationsOnAnAnnotatedType(Map<String, dynamic> context) {

  }

  @When("I test for annotations on an unannotated type")
  void whenITestForAnnotationsOnAnUnannotatedType(Map<String, dynamic> context) {

  }

  @When("I test for annotations")
  void whenITestForAnnotations(Map<String, dynamic> context) {

  }

  @When("I test for methods with a missing annotation")
  void whenITestForMethodsWithAMissingAnnotation(Map<String, dynamic> context) {

  }

  @When("I test for methods with an annotation")
  void whenITestForMethodsWithAnAnnotation(Map<String, dynamic> context) {

  }

  @When("I test for missing annotations")
  void whenITestForMissingAnnotations(Map<String, dynamic> context) {

  }

  @When("I test for static methods with a missing annotation")
  void whenITestForStaticMethodsWithAMissingAnnotation(Map<String, dynamic> context) {

  }

  @When("I test for static methods with an annotation")
  void whenITestForStaticMethodsWithAnAnnotation(Map<String, dynamic> context) {

  }

  @When("I test method parameters for a missing annotation")
  void whenITestMethodParametersForAMissingAnnotation(Map<String, dynamic> context) {

  }

  @When("I test method parameters for an annotation")
  void whenITestMethodParametersForAnAnnotation(Map<String, dynamic> context) {

  }

  @When("I test static and instance fields for a missing annotation")
  void whenITestStaticAndInstanceFieldsForAMissingAnnotation(Map<String, dynamic> context) {

  }

  @When("I test static and instance fields for an annotation")
  void whenITestStaticAndInstanceFieldsForAnAnnotation(Map<String, dynamic> context) {

  }

  @Then("getters and setters are found")
  void thenGettersAndSettersAreFound(Map<String, dynamic> context) {

  }

  @Then("no fields are found")
  void thenNoFieldsAreFound(Map<String, dynamic> context) {

  }

  @Then("no methods are found")
  void thenNoMethodsAreFound(Map<String, dynamic> context) {

  }

  @Then("no parameters are found")
  void thenNoParametersAreFound(Map<String, dynamic> context) {

  }

  @Then("some fields are found")
  void thenSomeFieldsAreFound(Map<String, dynamic> context) {

  }

  @Then("some methods are found")
  void thenSomeMethodsAreFound(Map<String, dynamic> context) {

  }

  @Then("some parameters are found")
  void thenSomeParametersAreFound(Map<String, dynamic> context) {

  }

  @Then("the test fails")
  void thenTheTestFails(Map<String, dynamic> context) {

  }

  @Then("the test is successful")
  void thenTheTestIsSuccessful(Map<String, dynamic> context) {

  }
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

