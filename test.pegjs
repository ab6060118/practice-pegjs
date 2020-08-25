start = p:PROJECT_STM ORDER_STM*

PROJECT_STM = PROJECT EQUAL KEYWORD
PROJECT = "project"i
EQUAL = ws? '=' / ws 'equal'i
KEYWORD = ws str:[A-Za-z0-9]+ {return str.join('')}

ORDER_STM = ORDER ws PROJECT (ASC / DESC)','?
ORDER = ws "order by"i
ASC = ws "asc"i
DESC = ws "desc"i

ws = [ \n\t\r]+
