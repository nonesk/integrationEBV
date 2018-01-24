import wrappers.wrapper_sql as wsql
from subprocess import call

call(['rm', 'kanar.db' ])

call(['touch', "kanar.db"] )

db = wsql.WrapperSQLite('kanar.db')
db.load_schema_sql('model.trim2.sql')
