start = query

query
  = operator:logical_operator
    {
      return {
        operator: operator
      }
    }
  / op:logical_operator _ right:query
    {
      return {
        ...right[0],
      }
    }
  / left:match op:logical_operator _ right:query*
    {
      return {
        left,
        operator: op,
        right: right[0],
      }
    }
  / match:match

sub_match 
  = "(" query:query+ ")" _* { return query[0] }

match 
  = _* f:match_condition _ v:value _*
    {
      return {
        ...f,
        value: v
      }
    }
  / sub_match

match_condition
  = f:equal_field? _+ o:equal_operator? { return { field: f, operator:o } }
  / f:field? _+ o:comparetion_operator? { return { field: f, operator:o } }

equal_field
  = field:('project'i/'assignee'i)

field
  = field:('updateDate'i)
  /equal_field

value
  = value:[a-z0-9]+ { return value.join('') }

equal_operator
  = op:('!='/'=')
  / 'is not'i { return '!=' }
  / 'is'i { return '=' }

comparetion_operator
  = op:('>='/'<='/'>'/'<')
  / equal_operator

logical_operator
  = op:('or'i/'and'i)

_
  = [ \n\r\t]

/* start */
/* = node:node order */
/* { */
  /* return node */
/* } */

/* node */
/* = field:field_exp op:operator_exp value:value_exp */
/* { */
  /* return { */
    /* field, */
    /* op, */
    /* value */
  /* } */
/* } */
/* / field:field_exp op:operator_exp value:value_exp */
/* { */
  /* return { */
    /* field, */
    /* op, */
    /* value */
  /* } */
/* } */

/* field_exp */
/* = _* field:field? _+ */
/* { */
  /* if(typeof field !== 'string') return 'field not support' */
  /* return field */
/* } */
/* / _* field eof */
/* { */
  /* if(typeof field !== 'string') return 'field not support' */
  /* return field */
/* } */

/* field */
/* = 'project'i */
/* / 'assignee'i */
/* / [^: \t\r\n\f\{\}()"+-/^~\[\]]+ */

/* value_exp */
/* = _* value:value _+ */
/* { */
  /* return value.join('') */
/* } */
/* / _* value:value eof */
/* { */
  /* return value.join('') */
/* } */

/* value */
/* = value:[a-z]+ */

/* operator_exp */
/* = _* operator:operator _+ */
/* { */
  /* return operator */
/* } */

/* operator */
/* = 'or'i */
/* / 'and'i */
/* / 'is'i */
/* / 'was'i */
/* / '<' */
/* / '>' */
/* / '=' */

/* order */
/* = _* 'order by'i _+ field */

/* _ 'whitespace' */
/* = [ \n\r\t] */

/* eof */
/* = !. */

/* unt = term:term+ { return term.join('') } */

/* term = '.' / [^: '"()] */

/* start = p:PROJECT_STM ORDER_STM* */

/* PROJECT_STM = (PROJECT/ASSIGNEE) EQUAL KEYWORD */
/* EQUAL = ws? '=' / ws 'equal'i */
/* KEYWORD = ws str:[A-Za-z0-9]+ {return str.join('')} */


/* PROJECT = "project"i */
/* ASSIGNEE = "assignee"i */


/* ORDER_STM = ORDER ws PROJECT (ASC / DESC)','? */
/* ORDER = ws "order by"i */
/* ASC = ws "asc"i */
/* DESC = ws "desc"i */

/* ws = [ \n\t\r]+ */
/* OPERATOR =  */
/* AND = "and"i */
/* OR = "or"i */
