import requests
import json
import feedparser as fp
import notify2
import os
import datetime
import webbrowser

DATA_DIR = os.path.expanduser('~/.data/')

with open("~/scripts/.env") as r:
    auth = json.load(r)

if not os.path.exists(DATA_DIR):
    os.makedirs(DATA_DIR, exist_ok=True)

EMAIL_JSON = os.path.join(DATA_DIR, 'email.json')
EMAIL_TXT = os.path.join(DATA_DIR, 'email.txt')

if os.path.exists(EMAIL_JSON):
    with open(EMAIL_JSON, 'r') as r:
        emails_dict = json.load(r)
else:
    emails_dict = dict()

COLORS = {
    'reset': '$color',
    'red': '${color ff0000}',
    'blue': '${color 0000ff}',
    'green': '${color 00ff00}',
    'bluish': '${color 0011ff}'
}

NO_OF_MAILS = 3


def shorten(string):
    if len(string) > 16:
        return string[:13] + "..."
    return string + ' ' * (16 - len(string))


def format_conky(address, count, mails):
    mails_str = '\n * '.join([f'{t}  -{s}' for t, s in mails])
    return (COLORS['red'] + f'{count} new mails' + COLORS['green'] +
            f'({"█"*6+address[6:]})' + COLORS['reset'] + '\n * ' + mails_str +
            '\n')


def format_notice(address, count, mails):
    mails_str = '\n * '.join([f'{t}  -{s}' for t, s in mails])
    return f'{count} new mails ({address})', ' * ' + mails_str


def send_notification(title, contents, url = None):
    notify2.init('Email Check')
    n = notify2.Notification(title, message=contents)
    n.set_urgency(notify2.URGENCY_CRITICAL)
    # if url is not None:
    #     def call_b(msg, action, url):
    #         webbrowser.open_new_tab(url)
    #     n.add_action('open-firefox', 'view', call_b, url)
    n.show()


new_emails_dict = dict()
dt = datetime.datetime.now().strftime('%H:%M %b-%d')
txt = '${color e43526}EMAILS: (' + dt + ')${color}\n'
for my_mail, my_pass in auth.items():
    new_emails_dict[my_mail] = dict()

    url = f'https://{my_mail}:{my_pass}@mail.google.com/mail/feed/atom/^smartlabel_personal'
    try:
        mail = fp.parse(requests.get(url).text)
    except requests.HTTPError:
        raise SystemExit('No internet')

    new_emails_dict[my_mail]['count'] = mail.feed.fullcount
    new_emails_dict[my_mail]['mails'] = [m['id'] for m in mail.entries]
    mails = []
    for i in range(min(NO_OF_MAILS, len(mail.entries))):
        title = mail.entries[i].title
        sender = ";".join(a.name for a in mail.entries[i].authors)
        mails.append((shorten(title), shorten(sender)))
    history = emails_dict.get(my_mail)
    if history is None or history[
            'count'] < mail.feed.fullcount or mail.entries[0][
                'id'] not in history['mails']:
        t, c = format_notice(my_mail, mail.feed.fullcount, mails)
        send_notification(t, c, url=mail.feed.link)

    txt += format_conky(my_mail, mail.feed.fullcount, mails)

with open(EMAIL_TXT, 'w') as writer:
    writer.write(txt)

with open(EMAIL_JSON, 'w') as writer:
    json.dump(new_emails_dict, writer)
