import os
import sys
import pickle

pickle.load("private.txt")
pwdlist = credential['pws']
usrlist = credential['users']
def getListofCredentials():
    credlist = []
    for i in range(0, len(userslist)): credlist += [(listpwd[i], userslist[i])]
    return credlist

def getListofCredentialsNg():
    credlist = []
    for i in range(0, len(userslist)): credlist.append([(listpwd[i], userslist[i])])
    return credlist

def run():
    credlist = []
    for i in range(0, len(userslist)):
        # pybot... with below
        (listpwd[i], userslist[i])
