return {
  ["session"] = function(args, kwargs, meta)
    return pandoc.RawInline('html', '<i class="fa-solid fa-calendar-day" title="A calendar with one day highlighted"></i> <strong>Session</strong>')
  end
}