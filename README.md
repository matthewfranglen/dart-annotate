Annotate
========

This provides a set of facades for dealing with annotations in Dart.

Annotations are very useful for reflection, as they allow you to add additional information to declarations. This library provides an easy way to test for and get annotations of specific types. Additional methods have been provided to make it easy to use in _where_ and _expand_ operations on Iterables.

Introduction
------------

Annotations are constant objects that are applied to declarations. They are available for inspection through the mirrors API.

An example annotation definition looks like:

    class ExampleAnnotation {
      const ExampleAnnotation();
    }

You can then annotate declarations with it:

    @ExampleAnnotation()
    class ExampleClass {
        @ExampleAnnotation()
        String exampleField;

        @ExampleAnnotation()
        void exampleMethod() {}

        ...
    }

Annotations can take arguments, allowing you to specify details about the specific declaration that has been annotated. For example:

    class ExampleSpecificAnnotation {
      final String detail;

      const ExampleSpecificAnnotation(this.detail);
    }

To retrieve those details you need to get the annotation object. This is slightly more involved, and it is this step that this library handles.

Synopsis
--------

Inspect object instances for annotations:

    class ExampleAnnotation {
      const ExampleAnnotation();
    }

    if (new InstanceAnnotationFacade(someObject).hasAnnotationOf(ExampleAnnotation)) {
        doSomething();
    }

    objectList
      .where(InstanceAnnotationFacade.filterByAnnotation(ExampleAnnotation))
      .forEach((Object instance) {
        doSomething();
      });

Get annotations of objects:

    Iterable<ExampleAnnotation> annotations =
      new InstanceAnnotationFacade(someObject).getAnnotationsOf(ExampleAnnotation);

    objectList
      .expand(InstanceAnnotationFacade.expandToAnnotations(ExampleAnnotation))
      .forEach((ExampleAnnotation annotation) {
        doSomething();
      });

Inspect types for annotations:

    @ExampleAnnotation()
    class ExampleType { }

    if (new TypeAnnotationFacade(ExampleType).hasAnnotationOf(ExampleAnnotation)) {
      doSomething();
    }

    typeList
      .where(TypeAnnotationFacade.filterByAnnotation(ExampleAnnotation))
      .forEach((Type type) {
        doSomething();
      });

Get annotations of types:

    Iterable<ExampleAnnotation> annotations =
      new TypeAnnotationFacade(ExampleType).getAnnotationsOf(ExampleAnnotation);

    typeList
      .expand(TypeAnnotationFacade.expandToAnnotations(ExampleAnnotation))
      .forEach((ExampleAnnotation annotation) {
        doSomething();
      });

Inspect DeclarationMirrors for annotations:

    DeclarationMirror mirror = reflect(someObject).type.declarations.values.first; // phew!

    if (new DeclarationAnnotationFacade(mirror).hasAnnotationOf(ExampleAnnotation)) {
      doSomething();
    }

    reflect(someObject).type.declarations.values
      .where(DeclarationAnnotationFacade.filterByAnnotation(ExampleAnnotation))
      .forEach((DeclarationMirror mirror) {
        doSomething();
      });

Get annotations of DeclarationMirrors:

    Iterable<ExampleAnnotation> annotations =
      new DeclarationAnnotationFacade(mirror).getAnnotationsOf(ExampleAnnotation);

    reflect(someObject).type.declarations.values
      .expand(DeclarationAnnotationFacade.expandToAnnotations(ExampleAnnotation))
      .forEach((ExampleAnnotation annotation) {
        doSomething();
      });

The names are too long!
-----------------------

Functions are first class objects in Dart, so you can alias the names to something more acceptable:

    var filterByAnnotation = InstanceAnnotationFacade.filterByAnnotation(ExampleAnnotation);

    objectList.where(filterByAnnotation(ExampleAnnotation))...

The values returned by the filterByAnnotation and expandToAnnotations methods are also methods, and so you can make your aliases even more specific:

    var objectFilter = InstanceAnnotationFacade.filterByAnnotation(ExampleAnnotation);

    objectList.where(objectFilter)...
