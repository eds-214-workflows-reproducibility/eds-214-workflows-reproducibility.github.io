return {
  ["lecture"] = function(args, kwargs, meta)
    return pandoc.RawInline('html', '<i class="fa-solid fa-person-chalkboard" title="A person motioning at a chalkboard"></i> <strong>Lecture slides</strong>')
  end
}