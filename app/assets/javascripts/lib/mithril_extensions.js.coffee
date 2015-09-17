m.computation = (callback) ->
  m.startComputation()
  callback()
  m.endComputation()

csrf_param = csrf_token = ""

$ ->
  csrf_param = $("[name=csrf-param]").attr("content")
  csrf_token = $("[name=csrf-token]").attr("content")

m.request_without_csrf = m.request
m.request = (options) ->
  data = options.data || {}
  data[csrf_param] = csrf_token
  options.data = data
  m.request_without_csrf(options)
