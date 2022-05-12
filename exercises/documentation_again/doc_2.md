Assume you have the following code:

  >require 'date'

  >puts Date.civil
  >puts Date.civil(2016)
  >puts Date.civil(2016, 5)
  >puts Date.civil(2016, 5, 13)

What will each of the 4 puts statements print?

If you look for the "date" class, the Date::civil returns the date in a fomat of yyyy-mm-dd

it has default arguments for the year, month and day so the puts would be as follows:

>puts Date.civil
returns "-4712-01-01"

>puts Date.civil(2016)
returns "2016-01-01"

>puts Date.civil(2016, 5)
returns "2016-05-01"

>puts Date.civil(2016, 5, 13)
returns "2016-05-13"