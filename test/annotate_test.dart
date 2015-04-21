import 'dart:async';
import 'dart:mirrors';
import 'package:annotate/annotate.dart';
import 'package:unittest/unittest.dart';
import 'package:behave/behave.dart';
import 'test_data.dart';

void main() {
  Feature feature = new Feature("Can test for annotations");

  feature.load(new _Steps());

  feature.scenario("Inspecting types for annotations")
    .when("I test for annotations on an annotated type")
    .then("the test is successful")
    .test();

  feature.scenario("Inspecting types for annotations")
    .when("I test for missing annotations on an annotated type")
    .then("the test fails")
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
    Symbol methodName = const Symbol('method');
    MethodMirror method = reflect(new AnnotatedClass.annotatedConstructor()).type.instanceMembers[methodName];
    context["method"] = method;
  }

  @Given("an annotated object")
  @Given("an object with annotated fields")
  @Given("an object with annotated methods")
  void givenAnAnnotatedObject(Map<String, dynamic> context) {
    context["object"] = new AnnotatedClass.annotatedConstructor();
  }

  @Given("an unannotated object")
  void givenAnUnannotatedObject(Map<String, dynamic> context) {
    context["object"] = new UnannotatedClass();
  }

  @When("I find methods with an annotation")
  void whenIFindMethodsWithAnAnnotation(Map<String, dynamic> context) {
    context["methods"] = reflect(context["object"]).type.instanceMembers.values
      .where(DeclarationAnnotationFacade.filterByAnnotation(Annotation));
  }

  @When("I test for annotations on an annotated type")
  void whenITestForAnnotationsOnAnAnnotatedType(Map<String, dynamic> context) {
    context["result"] = new TypeAnnotationFacade(AnnotatedClass).hasAnnotationOf(Annotation);
  }

  @When("I test for annotations on an unannotated type")
  void whenITestForAnnotationsOnAnUnannotatedType(Map<String, dynamic> context) {
    context["result"] = new TypeAnnotationFacade(UnannotatedClass).hasAnnotationOf(Annotation);
  }

  @When("I test for annotations")
  void whenITestForAnnotations(Map<String, dynamic> context) {
    context["result"] = new InstanceAnnotationFacade(context["object"]).hasAnnotationOf(Annotation);
  }

  @When("I test for methods with a missing annotation")
  void whenITestForMethodsWithAMissingAnnotation(Map<String, dynamic> context) {
    context["result"] = reflect(context["object"]).type.instanceMembers.values
      .where(DeclarationAnnotationFacade.filterByAnnotation(MissingAnnotation));
  }

  @When("I test for methods with an annotation")
  void whenITestForMethodsWithAnAnnotation(Map<String, dynamic> context) {
    context["result"] = reflect(context["object"]).type.instanceMembers.values
      .where(DeclarationAnnotationFacade.filterByAnnotation(Annotation));
  }

  @When("I test for missing annotations")
  void whenITestForMissingAnnotations(Map<String, dynamic> context) {
    context["result"] = new InstanceAnnotationFacade(context["object"]).hasAnnotationOf(MissingAnnotation);
  }

  @When("I test for missing annotations on an annotated type")
  void whenITestForMissingAnnotationsOnAnAnnotatedType(Map<String, dynamic> context) {
    context["result"] = new TypeAnnotationFacade(AnnotatedClass).hasAnnotationOf(MissingAnnotation);
  }

  @When("I test for static methods with a missing annotation")
  void whenITestForStaticMethodsWithAMissingAnnotation(Map<String, dynamic> context) {
    context["result"] = reflect(context["object"]).type.staticMembers.values
      .where(DeclarationAnnotationFacade.filterByAnnotation(MissingAnnotation));
  }

  @When("I test for static methods with an annotation")
  void whenITestForStaticMethodsWithAnAnnotation(Map<String, dynamic> context) {
    context["result"] = reflect(context["object"]).type.staticMembers.values
      .where(DeclarationAnnotationFacade.filterByAnnotation(Annotation));
  }

  @When("I test method parameters for a missing annotation")
  void whenITestMethodParametersForAMissingAnnotation(Map<String, dynamic> context) {
    context["result"] = (context["method"] as MethodMirror).parameters
      .where(DeclarationAnnotationFacade.filterByAnnotation(MissingAnnotation));
  }

  @When("I test method parameters for an annotation")
  void whenITestMethodParametersForAnAnnotation(Map<String, dynamic> context) {
    context["result"] = (context["method"] as MethodMirror).parameters
      .where(DeclarationAnnotationFacade.filterByAnnotation(Annotation));
  }

  @When("I test static and instance fields for a missing annotation")
  void whenITestStaticAndInstanceFieldsForAMissingAnnotation(Map<String, dynamic> context) {
    context["result"] = reflect(context["object"]).type.declarations.values
      .where(isVariableMirror)
      .map(toVariableMirror)
      .where(DeclarationAnnotationFacade.filterByAnnotation(MissingAnnotation));
  }

  @When("I test static and instance fields for an annotation")
  void whenITestStaticAndInstanceFieldsForAnAnnotation(Map<String, dynamic> context) {
    context["result"] = reflect(context["object"]).type.declarations.values
      .where(isVariableMirror)
      .map(toVariableMirror)
      .where(DeclarationAnnotationFacade.filterByAnnotation(Annotation));
  }

  @Then("getters and setters are found")
  void thenGettersAndSettersAreFound(Map<String, dynamic> context) {
    Iterable<MethodMirror> result = context["methods"] as Iterable;

    Symbol getterName, setterName;
    bool hasGetters, hasSetters;

    getterName = const Symbol('annotatedGetter');
    hasGetters = result.any((MethodMirror method) => method.simpleName == getterName);

    setterName = const Symbol('annotatedSetter=');
    hasSetters = result.any((MethodMirror method) => method.simpleName == setterName);

    expect(hasGetters, isTrue);
    expect(hasSetters, isTrue);
  }

  @Then("no fields are found")
  @Then("no methods are found")
  @Then("no parameters are found")
  void thenNoResultsFound(Map<String, dynamic> context) {
    Iterable<dynamic> result = context["result"] as Iterable;
    expect(result, isEmpty);
  }

  @Then("some fields are found")
  @Then("some methods are found")
  @Then("some parameters are found")
  void thenSomeResultsFound(Map<String, dynamic> context) {
    Iterable<dynamic> result = context["result"] as Iterable;
    expect(result, isNotEmpty);
  }

  @Then("the test fails")
  void thenTheTestFails(Map<String, dynamic> context) {
    bool result = context["result"] as bool;
    expect(result, isFalse);
  }

  @Then("the test is successful")
  void thenTheTestIsSuccessful(Map<String, dynamic> context) {
    bool result = context["result"] as bool;
    expect(result, isTrue);
  }
}

bool isVariableMirror(DeclarationMirror mirror) =>
  mirror is VariableMirror;

VariableMirror toVariableMirror(DeclarationMirror mirror) =>
  mirror as VariableMirror;

// vim: set ai et sw=2 syntax=dart :
