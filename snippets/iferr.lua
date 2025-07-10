local ls = require 'luasnip'
ls.add_snippets(nil, {
  all = {
    snip({ trig = 'date', namr = 'Date', dscr = 'Date in the form of YYYY-MM-DD' }, { func(date, {}) }),
  },
})
