part of annotate;

/// Defines the methods that all AnnotationFacades implementations provide.
abstract class AnnotationFacade {

  /// Tests for any annotation which can be assigned to the [annotation] type.
  bool hasAnnotationOf(Type annotation);

  /// Returns all annotations which can be assigned to the [annotation] type.
  Iterable<dynamic> getAnnotationsOf(Type annotation);
}

/// Implements the AnnotationFacade methods but requires a source of annotations.
///
/// Determining if an annotation of a given type exists, or finding annotations
/// of a given type, is entirely separate from getting the annotations from a
/// source. This class allows the type specific facades to just concentrate on
/// extracting the annotations from the source data.
abstract class AbstractAnnotationFacade extends AnnotationFacade {

  Iterable<InstanceMirror> _getAnnotations();

  bool hasAnnotationOf(Type annotation) =>
    _getAnnotations()
      .any(_isType(annotation));

  Iterable<dynamic> getAnnotationsOf(Type annotation) =>
    _getAnnotations()
      .where(_isType(annotation))
      .map(_toReflectee);

  AnnotationFilter _isType(Type type) {
    TypeMirror typeMirror = reflectType(type);

    return (InstanceMirror annotation) =>
      isSubtypeOf(annotation.type, typeMirror);
  }

  dynamic _toReflectee(InstanceMirror mirror) => mirror.reflectee;
}

/// Provides annotation handling for objects.
///
/// Inspect object instances for annotations:
///
///     class ExampleAnnotation {
///       const ExampleAnnotation();
///     }
///
///     if (new InstanceAnnotationFacade(someObject).hasAnnotationOf(ExampleAnnotation)) {
///         doSomething();
///     }
///
///     objectList
///       .where(InstanceAnnotationFacade.filterByAnnotation(ExampleAnnotation))
///       .forEach((Object instance) {
///         doSomething();
///       });
///
/// Get annotations of objects:
///
///     Iterable<ExampleAnnotation> annotations =
///       new InstanceAnnotationFacade(someObject).getAnnotationsOf(ExampleAnnotation);
///
///     objectList
///       .expand(InstanceAnnotationFacade.expandToAnnotations(ExampleAnnotation))
///       .forEach((ExampleAnnotation annotation) {
///         doSomething();
///       });
class InstanceAnnotationFacade extends AbstractAnnotationFacade {

  final Object _instance;

  /// This static constructor allows facade creation in a map
  ///
  ///     objectList.map(InstanceAnnotationFacade.toFacade)...
  static InstanceAnnotationFacade toFacade(Object instance) =>
    new InstanceAnnotationFacade(instance);

  /// This returns a method which accepts objects with assignable annotations
  ///
  ///     objectList.where(InstanceAnnotationFacade.filterByAnnotation(ExampleAnnotation))...
  static AnnotationFilter filterByAnnotation(Type annotation) =>
    (Object instance) => new InstanceAnnotationFacade(instance).hasAnnotationOf(annotation);

  /// This returns a method which expands objects to the assignable annotations
  ///
  ///     objectList.expand(InstanceAnnotationFacade.expandToAnnotations(ExampleAnnotation))...
  static AnnotationTransform expandToAnnotations(Type annotation) =>
    (Object instance) => new InstanceAnnotationFacade(instance).getAnnotationsOf(annotation);

  InstanceAnnotationFacade(this._instance);

  Iterable<InstanceMirror> _getAnnotations() =>
    reflectClass(_instance.runtimeType).metadata;
}

/// Provides annotation handling for types.
///
/// Inspect types for annotations:
///
///     @ExampleAnnotation()
///     class ExampleType { }
///
///     if (new TypeAnnotationFacade(ExampleType).hasAnnotationOf(ExampleAnnotation)) {
///       doSomething();
///     }
///
///     typeList
///       .where(TypeAnnotationFacade.filterByAnnotation(ExampleAnnotation))
///       .forEach((Type type) {
///         doSomething();
///       });
///
/// Get annotations of types:
///
///     Iterable<ExampleAnnotation> annotations =
///       new TypeAnnotationFacade(ExampleType).getAnnotationsOf(ExampleAnnotation);
///
///     typeList
///       .expand(TypeAnnotationFacade.expandToAnnotations(ExampleAnnotation))
///       .forEach((ExampleAnnotation annotation) {
///         doSomething();
///       });
class TypeAnnotationFacade extends AbstractAnnotationFacade {

  final Type _type;

  /// This static constructor allows facade creation in a map
  ///
  ///     typeList.map(TypeAnnotationFacade.toFacade)...
  static TypeAnnotationFacade toFacade(Type type) =>
    new TypeAnnotationFacade(type);

  /// This returns a method which accepts types with assignable annotations
  ///
  ///     typeList.where(TypeAnnotationFacade.filterByAnnotation(ExampleAnnotation))...
  static AnnotationFilter filterByAnnotation(Type annotation) =>
    (Type type) => new TypeAnnotationFacade(type).hasAnnotationOf(annotation);

  /// This returns a method which expands types to the assignable annotations
  ///
  ///     typeList.expand(TypeAnnotationFacade.expandToAnnotations(ExampleAnnotation))...
  static AnnotationTransform expandToAnnotations(Type annotation) =>
    (Type type) => new TypeAnnotationFacade(type).getAnnotationsOf(annotation);

  TypeAnnotationFacade(this._type);

  Iterable<InstanceMirror> _getAnnotations() =>
    reflectType(_type).metadata;
}

/// Provides annotation handling for declaration mirrors.
///
/// Inspect DeclarationMirrors for annotations:
///
///     DeclarationMirror mirror = reflect(someObject).type.declarations.values.first; // phew!
///
///     if (new DeclarationAnnotationFacade(mirror).hasAnnotationOf(ExampleAnnotation)) {
///       doSomething();
///     }
///
///     reflect(someObject).type.declarations.values
///       .where(DeclarationAnnotationFacade.filterByAnnotation(ExampleAnnotation))
///       .forEach((DeclarationMirror mirror) {
///         doSomething();
///       });
///
/// Get annotations of DeclarationMirrors:
///
///     Iterable<ExampleAnnotation> annotations =
///       new DeclarationAnnotationFacade(mirror).getAnnotationsOf(ExampleAnnotation);
///
///     reflect(someObject).type.declarations.values
///       .expand(DeclarationAnnotationFacade.expandToAnnotations(ExampleAnnotation))
///       .forEach((ExampleAnnotation annotation) {
///         doSomething();
///       });
class DeclarationAnnotationFacade extends AbstractAnnotationFacade {

  final DeclarationMirror _declaration;

  /// This static constructor allows facade creation in a map
  ///
  ///     declarationList.map(DeclarationAnnotationFacade.toFacade)...
  static DeclarationAnnotationFacade toFacade(DeclarationMirror declaration) =>
    new DeclarationAnnotationFacade(declaration);

  /// This returns a method which accepts declarations with assignable annotations
  ///
  ///     declarationList.where(DeclarationAnnotationFacade.filterByAnnotation(ExampleAnnotation))...
  static AnnotationFilter filterByAnnotation(Type annotation) =>
    (DeclarationMirror declaration) =>
      new DeclarationAnnotationFacade(declaration).hasAnnotationOf(annotation);

  /// This returns a method which expands declarations to the assignable annotations
  ///
  ///     declarationList.expand(DeclarationAnnotationFacade.expandToAnnotations(ExampleAnnotation))...
  static AnnotationTransform expandToAnnotations(Type annotation) =>
    (DeclarationMirror declaration) =>
      new DeclarationAnnotationFacade(declaration).getAnnotationsOf(annotation);

  DeclarationAnnotationFacade(this._declaration);

  Iterable<InstanceMirror> _getAnnotations() =>
      _declaration.metadata;
}

/// Test value for annotations
typedef bool AnnotationFilter(dynamic value);

/// Turn value into zero or more annotations
typedef List<dynamic> AnnotationTransform(dynamic value);

// vim: set ai et sw=2 syntax=dart :
