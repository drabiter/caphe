class Caphe

  @mixin: (consumer, providers...) ->
    for provider in providers
      for k, v of provider
        consumer[k] = v if provider.hasOwnProperty(k)

    consumer


  @include: (module, names...) ->
    _ = module
    if names.length isnt 0
      _ = {}
      _[name] = module[name] for name in names

    @mixin(@prototype, _)


  @attrAccessor: (fields...) ->
    @_createGetterSetter(fields...)


  @CONST: (constants) ->
    _proto = Caphe.prototype
    for key, value of constants
      @prototype[key.toUpperCase()] = _proto._createConstantMethod(value)


  @forward: (consumer, providers...) ->
    _proto = Caphe.prototype
    for provider in providers
      for k, v of provider
        if provider.hasOwnProperty(k)
          consumer[k] = _proto._createForwardMethod(k, provider)

    consumer


  @delegate: (consumer, providers...) ->
    _proto = Caphe.prototype
    for provider in providers
      for k, v of provider
        if provider.hasOwnProperty(k)
          consumer[k] = _proto._createDelegateMethod(consumer, k, provider)

    consumer


  # private

  @_createGetterSetter: (fields...) ->
    _methods = {}
    for field in fields
      titleized = Caphe.prototype._titleize(field)
      _methods["get#{titleized}"] = Caphe.prototype._createGetter(field)
      _methods["set#{titleized}"] = Caphe.prototype._createSetter(field)

    @_privateMixin(@prototype, _methods)

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

  _titleize: (str) ->
    str.charAt(0).toUpperCase() + str.substring(1)

  # _typeName: (param) ->
  #   return Object.prototype.toString.call(param).match(/\s([a-z|A-Z]+)/)[1].toLowerCase()


module.exports = Caphe
