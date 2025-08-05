return {
  ["interactive"] = function(args, kwargs, meta)
    return pandoc.RawInline('html', '<i class="fa-solid fa-laptop-code" title="A laptop with on-screen code"></i> <strong>Interactive session</strong>')
  end
}