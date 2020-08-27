var { parse } = require('./test')

console.log(JSON.stringify(parse('project is not a and updateDate < 2 and assignee = 2 or project = 3'), null, 2))
