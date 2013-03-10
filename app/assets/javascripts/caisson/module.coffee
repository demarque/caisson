@caissonMod = (names, fn) ->
  names = names.split '.' if typeof names is 'string'
  space = @[names.shift()] ||= {}
  space.caissonMod ||= @caissonMod
  if names.length
    space.caissonMod names, fn
  else
    fn.call space
