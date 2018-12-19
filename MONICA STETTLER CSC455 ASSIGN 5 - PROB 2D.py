# -*- coding: utf-8 -*-
"""
Created on Tue Mar  6 16:31:29 2018

@author: Monica
"""

import urllib.request, time, json, sqlite3

conn = sqlite3.connect('Tweets_Database2.db')
c = conn.cursor()
wFD = urllib.request.urlopen('http://rasinsrv07.cstcis.cti.depaul.edu/CSC455/Assignment5.txt')

createTable = '''CREATE TABLE Tweets (
                 id_str          NUMBER(20),
                 Created_At  DATE,
                 Text        CHAR(140),
                 Source VARCHAR(200) DEFAULT NULL,
                 In_Reply_to_User_ID NUMBER(20),
                 In_Reply_to_Screen_Name VARCHAR(60),
                 In_Reply_to_Status_ID NUMBER(20),
                 Retweet_Count NUMBER(10),
                 Contributors  VARCHAR(200),
                 User_id NUMBER(20),
                 CONSTRAINT Tweets_PK  PRIMARY KEY (id_str),
                 CONSTRAINT Users_FK FOREIGN KEY(User_ID)
                 REFERENCES Users(id_str)
              );'''

c.execute('DROP TABLE IF EXISTS Tweets');
c.execute(createTable)

#************************
createUsersTable = '''CREATE TABLE Users (
                 id_str          NUMBER(20),
                 Name VARCHAR2(20),
                 screen_name VARCHAR(200),
                 description NUMBER(200),
                 friends_count NUMBERS(8),
                 CONSTRAINT Users_PK  PRIMARY KEY (id_str)
              );'''
c.execute('DROP TABLE IF EXISTS Users');
c.execute(createUsersTable)

def loadTweets(tweetLines):

    # Collect multiple rows so that we can use "executemany".  We do
    # not want to collect all of the numLines rows because there may
    # not be enough memory for that. So we insert batchRows at a time
    batchRows = 50
    batchedInserts = []

    # as long as there is at least one line remaining
    while len(tweetLines) > 0:
        line = tweetLines.pop(0) # take off the first element from the list, removing it

        tweetDict = json.loads(line)

        newRow = [] # hold individual values of to-be-inserted row
        tweetKeys = ['id_str','created_at','text','source','in_reply_to_user_id', 'in_reply_to_screen_name', 'in_reply_to_status_id', 'retweet_count', 'contributors', 'user_id']

        for key in tweetKeys:
            # Treat '', [] and 'null' as NULL
            if tweetDict[key] in ['',[],'null']:
                newRow.append(None)
            else:
                newRow.append(tweetDict[key])

        # Add the new row to the collected batch
        batchedInserts.append(newRow)

        # If we have reached # of batchRows, use executemany to insert what we collected
        # so far, and reset the batchedInserts list back to empty
        if len(batchedInserts) >= batchRows or len(tweetLines) == 0:
            c.executemany('INSERT INTO Tweets VALUES(?,?,?,?,?,?,?,?,?,?)', batchedInserts)
            # Reset the batching process
            batchedInserts = []
            
        for tweet in allTweets:
            try:
                tdict = json.loads(tweet.decode('utf8'))
            except ValueError:
                outF = open("Assignment_errors.txt", "w")
                outF.write(line)
                outF.close()
      # Handle the problematic tweet, which in your case would require writing it to another file
     
              
            
def loadTweets2(tweetLines2):

    # Collect multiple rows so that we can use "executemany".  We do
    # not want to collect all of the numLines rows because there may
    # not be enough memory for that. So we insert batchRows at a time
    batchRows = 50
    batchedInserts = []

    # as long as there is at least one line remaining
    while len(tweetLines2) > 0:
        line = tweetLines2.pop(0) # take off the first element from the list, removing it

        tweetDict = json.loads(line)

        newRow = [] # hold individual values of to-be-inserted row
        tweetKeys = ['id', 'name', 'screen_name', 'description', 'friends_count']

        for key in tweetKeys:
            # Treat '', [] and 'null' as NULL
            if tweetDict[key] in ['',[],'null']:
                newRow.append(None)
            else:
                newRow.append(tweetDict[key])

        # Add the new row to the collected batch
        batchedInserts.append(newRow)

        # If we have reached # of batchRows, use executemany to insert what we collected
        # so far, and reset the batchedInserts list back to empty
        if len(batchedInserts) >= batchRows or len(tweetLines2) == 0:
            c.executemany('INSERT INTO Users VALUES(?,?,?,?,?)', batchedInserts)
            # Reset the batching process
            batchedInserts = []
            
        for tweet in allTweets:
            try:
                tdict = json.loads(tweet.decode('utf8'))
            except ValueError:
                outF = open("Assignment_errors.txt", "w")
                print (tweet[:50])
                outF.close()
      # Handle the problematic tweet, which in your case would require writing it to another file
     
    

start = time.time()
tweets = wFD.read()
loadTweets( tweets.decode('utf8').split('EndOfTweet') )
end   = time.time()

print ("loadTweets took ", (end-start), ' seconds.')
print ("Loaded ", c.execute('SELECT COUNT(*) FROM Tweets').fetchall()[0], " rows")

wFD.close()
c.close()
conn.commit()
conn.close()
