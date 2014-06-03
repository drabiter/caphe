class Caphe

  @mixin: (consumer, providers...) ->
    for provider in providers
      for k, v of provider
        consumer[k] = v if provider.hasOwnProperty(k)

    consumer


  @include: (modules...) ->
    @mixin(@::, modules...)


  @attrAccessor: (fields...) ->
    @_createGetterSetter(fields...)


  # private

  @_createGetterSetter: (fields...) ->
    _methods = {}
    for field in fields
      titleized = Caphe::titleize(field)
      _methods["get#{titleized}"] = Caphe::_createGetter(field)
      _methods["set#{titleized}"] = Caphe::_createSetter(field)

    @_privateMixin(@::, _methods)

  @_privateMixin: (consumer, providers...) ->
    for provider in providers
      _privateProperties = Object.create(null)
      for k, v of provider
        consumer[k] = v.bind(_privateProperties) if provider.hasOwnProperty(k)

    consumer

  @CONST: (constants) ->
    for key, value of constants
      @::[key.toUpperCase()] = Caphe::_createConstantMethod(value)


  # private

  @_privateMixin: (consumer, providers...) ->
    for provider in providers
      _privateProperties = Object.create(null)
      for k, v of provider
        consumer[k] = v.bind(_privateProperties) if provider.hasOwnProperty(k)

    consumer

  _createGetter: (field) ->
    () -> @[field]

  _createSetter: (field) ->
    (value) -> @[field] = value

  _createConstantMethod: (value) ->
    () -> value

  titleize: (str) ->
    str.charAt(0).toUpperCase() + str.substring(1)


module.exports = Caphe
