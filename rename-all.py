#!/bin/python
import os
import sys


if len(sys.argv) > 1:
    base = sys.argv[1]
else:
    base = '.'


def rename(filename):
    path = filename.split('/')
    if path[-1][0]=='.':
        return
    new_name = os.path.join('/'.join(path[:-1]),path[-1].replace(' ', '-').lower())
    if filename != new_name:
        print(f'renaming: {filename}->{new_name}')
        os.rename(filename, new_name)
        return new_name


def rename_recursive(path):
    if os.path.isdir(path):
        listdir = os.listdir(path)
        for l in listdir:
            rename_recursive(os.path.join(path,l))
        rename(path)
    else:
        rename(path)


rename_recursive(base)
