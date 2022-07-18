#!/usr/bin/env python 
import orgparse
import conky_formatting as cf

todo_org = "/home/gaurav/todo.org"
todo = orgparse.load(todo_org,
                     orgparse.node.OrgEnv(
                         todos=['TODO','HOLD','PROG'],
                         dones=['DONE','DROP'],
                         filename=todo_org))

symbol_level= {
    1:'*',
    2:'-',
    3:'+',
    4:'>',
    5:' '
}


for node in todo[1:]:
    count = node.level
    if count > 4:
        pass
    if node.todo == None:
        color = cf.from_color_hex(int(0xffff00 * (1-count/5)) + 0xff)
        print(f'{color}{" "*count}{symbol_level[count]} {node.heading}{cf.COLOR_RESET}')
    elif node.todo == 'TODO':
        color = cf.orange_pallet[count-1]
        print(f'{color}{" "*count}{symbol_level[count]} {node.heading}{cf.COLOR_RESET}')
    elif node.todo == 'HOLD':
        color = cf.from_color_hex(int(0xaaaaaa * (1-count/5)))
        print(f'{color}{" "*count}{symbol_level[count]} {node.heading}{cf.COLOR_RESET}')
    elif node.todo == 'PROG':
        color = cf.from_color_hex(int(0x000099 + (1-count/5) * 0x666666))
        print(f'{color}{" "*count}{symbol_level[count]} {node.heading}{cf.COLOR_RESET}')
    else:
        pass

