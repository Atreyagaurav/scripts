#!/usr/bin/env python

import json
import os
import sys
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


def read_auths():
    with open(os.path.expanduser("~/scripts/.env")) as r:
        auth = json.load(r)
    return auth


def send_msg(subject, content):
    msg = MIMEMultipart()
    auth = read_auths()
    msg['To'] = auth.pop('outgoing')
    email, key = list(auth.items())[0]
    msg['From'] = email
    msg['Subject'] = subject
    msg.attach(MIMEText(content, 'plain'))
    server = smtplib.SMTP('smtp.gmail.com:587')
    server.starttls()
    server.login(email, key)
    text = msg.as_string()
    print("Sending email.... Please wait...")
    server.sendmail("Auto Alert", msg['To'], text)
    server.quit()


if __name__ == '__main__':
    try:
        send_msg(sys.argv[1],
                 " ".join(sys.argv[2:]))
    except IndexError:
        print(f"Usage: {sys.argv[0]} 'Email Subject' Email Contents")
        print("\nThe subject needs to be quoted, the email does not.")
