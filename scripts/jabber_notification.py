#!/usr/bin/python
# Copyright 2004 Alex de la Mare <alexdlm@users.sourceforge.net> JID: alexdlm@jabber.vesania.com
# Under the GPL.
# Bits and peices taken from jabber.py examples

# Python script to be used with Subversion hooks (specifically post-commit) to send messages
# via Jabber to users.

# Depends on the jabberpy library available at http://jabberpy.sourceforge.net
# Requires svnlook.

# Install in your repositories hook dir, as post-commit.

import sys
from string import strip
import commands

import jabber #TODO: Make sure this is right. Its fine if you put the jabber.py files next to this one.

#TODO: Set variable for jabber connection
Server = 'jabber.berlin.ccc.de'
Username = 'pentabarf'
Password = 'haase-kellertank'
Resource = 'Subversion'

#TODO: Set list of contacts to spam
recvs = ['sven@jabber.berlin.ccc.de', 'tim@jabber.berlin.ccc.de', 'fukami@jabber.ccc.de', 'turbo24prg@jabber.ccc.de', 'petr@jabber.ccc.de', 'tristan-777@jabber.ccc.de', 'fd0@avalon.hoffentlich.net']
  
def disconnectedCB(con):
    sys.exit(0)

def messageCB(con, msg):
    pass
    
def presenceCB(con, prs):
    pass
    
def iqCB(con,iq):
    pass
    
def sendMsg(text):    
  # JABBER STUFF FOLLOWS    
     
  con = jabber.Client(Server)
  
  try:
      con.connect()
  except IOError, e:
      print "Couldn't connect: %s" % e
      sys.exit(0)
      
  #Dont think these are really needed, but meh.
  con.registerHandler('message',messageCB)
  con.registerHandler('presence',presenceCB)
  con.registerHandler('iq',iqCB)
  #This one probably is needed.
  con.setDisconnectHandler(disconnectedCB)
  
  if con.auth(Username,Password,Resource):
    #print "Logged in"
    pass
  else:
    #print "AUTH FAILURE"
    con.disconnect()
    sys.exit(1)
      
  for r in recvs:
    msg = jabber.Message(r, text)
    msg.setType('normal')
    msg.setSubject('subversion commit in pentabarf')
    con.send(msg)
    con.process(1)

  con.disconnect()    
    
if len(sys.argv) != 3:
   sys.stderr.write("USAGE: %s REPOS-DIR REVISION\n" % (sys.argv[0]))
   sys.exit(1)
   
repos_dir = sys.argv[1]
revision = int(sys.argv[2])

author = commands.getoutput("svnlook author %s --revision %s" % (repos_dir, revision))
when   = commands.getoutput("svnlook date %s --revision %s" % (repos_dir, revision))
log    = commands.getoutput("svnlook log  %s --revision %s" % (repos_dir, revision))
what   = commands.getoutput("svnlook changed %s --revision %s" % (repos_dir, revision))

output = "Commit from %s at %s:\n" % (author, when)
output += "Log: %s\n" % (log)
output += "Changed (%s - Now rev %s): \n%s" % (repos_dir, revision, what)

sendMsg(output)
