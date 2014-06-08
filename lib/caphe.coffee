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


  @CONST: (constants) ->
    for key, value of constants
      @::[key.toUpperCase()] = Caphe::_createConstantMethod(value)


  @forward: (consumer, providers...) ->
    for provider in providers
      for k, v of provider
        if provider.hasOwnProperty(k)
          consumer[k] = Caphe::_createForwardMethod(k, provider)

    consumer


  @delegate: (consumer, providers...) ->
    for provider in providers
      for k, v of provider
        if provider.hasOwnProperty(k)
          consumer[k] = Caphe::_createDelegateMethod(consumer, k, provider)

    consumer


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

  _createGetter: (field) ->
    () -> @[field]

  _createSetter: (field) ->
    (value) -> @[field] = value

  _createConstantMethod: (value) ->
    () -> value

  _createForwardMethod: (funcName, provider) ->
    () -> provider[funcName].apply(provider, arguments)

  _createDelegateMethod: (consumer, funcName, provider) ->
    () -> provider[funcName].apply(consumer, arguments)

  titleize: (str) ->
    str.charAt(0).toUpperCase() + str.substring(1)


module.exports = Caphe
