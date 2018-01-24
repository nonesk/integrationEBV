import wrappers.wrapper_sql as wsql
from subprocess import call, Popen

call(['rm', 'kanar.db' ])

call(['touch', "kanar.db"] )

call(["sed", "-i", "/^#/d", "model.sql"])
call(['sed', "-i", 's/autoincrement/AUTO_INCREMENT/g', "model.sql"])

db = wsql.WrapperSQLite('kanar.db')
db.load_schema_sql('model.sql')
