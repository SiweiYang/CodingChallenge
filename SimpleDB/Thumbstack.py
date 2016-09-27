import sys

db = {}
numdb = {}
trans = []

def set_val(var, nval, db, numdb):
    try:
        val = db[var]
    except KeyError:
        val = None
    
    try:
        numdb[val]
    except KeyError:
        numdb[val] = 0
    try:
        numdb[nval]
    except KeyError:
        numdb[nval] = 0
    try:
        numdb[val] = numdb[val] - 1
        numdb[nval] = numdb[nval] + 1
    except KeyError:
        pass
    
    db[var] = nval
    if not nval:
        db.pop(var)
    return (var, val)

# Enter your code here. Read input from STDIN. Print output to STDOUT
while True:
    line = sys.stdin.readline()
    print(line.strip())
    if line.strip() == 'END':
        break
    
    cmd = line.strip().split()
    if cmd[0] == 'BEGIN':
        trans.append({})
    elif cmd[0] == 'ROLLBACK':
        if not trans:
            print('> NO TRANSACTION')
            continue
            
        undos = trans.pop()
        for (var, val) in undos.items():
            set_val(var, val, db, numdb)
    elif cmd[0] == 'COMMIT':
        if not trans:
            print('> NO TRANSACTION')
            continue
            
        trans = []
    if cmd[0] == 'GET':
        try:
            val = db[cmd[1]]
        except KeyError:
            val = 'NULL'
        print('> %s' % val)
    elif cmd[0] == 'NUMEQUALTO':
        try:
            val = numdb[cmd[1]]
        except KeyError:
            val = 0
        print('> %d' % val)
    elif cmd[0] == 'SET':
        (var, val) = set_val(cmd[1], cmd[2], db, numdb)
        if trans:
            try:
                trans[-1][var]
            except KeyError:
                trans[-1][var] = val
    elif cmd[0] == 'UNSET':
        (var, val) = set_val(cmd[1], None, db, numdb)
        if trans:
            try:
                trans[-1][var]
            except KeyError:
                trans[-1][var] = val