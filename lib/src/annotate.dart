part of annotate;

abstract class AnnotationFacade {

  bool hasAnnotationOf(Type annotation);

  Iterable<dynamic> getAnnotationsOf(Type annotation);
}

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

class InstanceAnnotationFacade extends AbstractAnnotationFacade {

  final Object _instance;

  static InstanceAnnotationFacade toFacade(Object instance) =>
    new InstanceAnnotationFacade(instance);

  static AnnotationFilter filterByAnnotation(Type annotation) =>
    (Object instance) => new InstanceAnnotationFacade(instance).hasAnnotationOf(annotation);

  static AnnotationTransform expandToAnnotations(Type annotation) =>
    (Object instance) => new InstanceAnnotationFacade(instance).getAnnotationsOf(annotation);

  InstanceAnnotationFacade(this._instance);

  Iterable<InstanceMirror> _getAnnotations() =>
    reflectClass(_instance.runtimeType).metadata;
}

class TypeAnnotationFacade extends AbstractAnnotationFacade {

  final Type _type;

  static TypeAnnotationFacade toFacade(Type type) =>
    new TypeAnnotationFacade(type);

  static AnnotationFilter filterByAnnotation(Type annotation) =>
    (Type type) => new TypeAnnotationFacade(type).hasAnnotationOf(annotation);

  static AnnotationTransform expandToAnnotations(Type annotation) =>
    (Type type) => new TypeAnnotationFacade(type).getAnnotationsOf(annotation);

  TypeAnnotationFacade(this._type);

  Iterable<InstanceMirror> _getAnnotations() =>
    reflectType(_type).metadata;
}

class DeclarationAnnotationFacade extends AbstractAnnotationFacade {

  final DeclarationMirror _declaration;

  static DeclarationAnnotationFacade toFacade(DeclarationMirror declaration) =>
    new DeclarationAnnotationFacade(declaration);

  static AnnotationFilter filterByAnnotation(Type annotation) =>
    (DeclarationMirror declaration) =>
      new DeclarationAnnotationFacade(declaration).hasAnnotationOf(annotation);

  static AnnotationTransform expandToAnnotations(Type annotation) =>
    (DeclarationMirror declaration) =>
      new DeclarationAnnotationFacade(declaration).getAnnotationsOf(annotation);

  DeclarationAnnotationFacade(this._declaration);

  Iterable<InstanceMirror> _getAnnotations() =>
      _declaration.metadata;
}

typedef bool AnnotationFilter(dynamic value);

typedef List<dynamic> AnnotationTransform(dynamic value);

// vim: set ai et sw=2 syntax=dart :
