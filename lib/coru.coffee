class Coru

  @mixin: (consumer, providers...) ->
    for provider in providers
      for k, v of provider
        consumer[k] = v if provider.hasOwnProperty(k)

    consumer


  @_privateMixin: (consumer, providers...) ->
    for provider in providers
      _privateProperties = Object.create(null)
      for k, v of provider
        consumer[k] = v.bind(_privateProperties) if provider.hasOwnProperty(k)

    consumer


  @include: (modules...) ->
    @mixin(@::, modules...)


  @attrAccessor: (fields...) ->
    _methods = {}
    for field in fields
      titleized = Coru::titleize(field)
      _methods["get#{titleized}"] = Coru::_createGetter(field)
      _methods["set#{titleized}"] = Coru::_createSetter(field)

    @_privateMixin(@::, _methods)


  _createGetter: (field) ->
    () ->
      @[field]

  _createSetter: (field) ->
    (value) ->
      @[field] = value

  titleize: (str) ->
    str.charAt(0).toUpperCase() + str.substring(1)


module.exports = Coru
