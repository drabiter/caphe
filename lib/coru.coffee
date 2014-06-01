class Coru

  @mixin: (consumer, providers...) ->
    for provider in providers
      for k, v of provider
        consumer[k] = v if provider.hasOwnProperty(k)

    consumer


module.exports = coru
