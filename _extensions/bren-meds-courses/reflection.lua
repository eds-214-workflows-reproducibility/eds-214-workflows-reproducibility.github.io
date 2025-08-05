return {
  ["reflection"] = function(args, kwargs, meta)
    return pandoc.RawInline('html', '<i class="fa-solid fa-brain" title="A brain representing thinking and reflection"></i> <strong>Reflection</strong>')
  end
}